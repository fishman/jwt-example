/*
 *
 * Copyright 2018 Reza Jelveh
 * Copyright 2015 gRPC authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package main

import (
	"fmt"
	"log"
	"net"

	pb "greeter_proto"

	jwt "github.com/dgrijalva/jwt-go"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/reflection"
)

const (
	port = ":50051"
	key  = "9cdd3c973b10b17f106d029e54ce1250f2a0062eccd7cf439ab2733c987dc2b5956898933962c6a71d5e9eabf2e9242225d817e5d0c16a36d529c03d502e2b64"
)

// server is used to implement helloworld.GreeterServer.
type server struct{}

func validateToken(token string) (*jwt.Token, error) {
	jwtToken, err := jwt.Parse(token, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("Unexpected signing method")
		}

		return []byte(key), nil
	})
	if err == nil && jwtToken.Valid {
		return jwtToken, nil
	}
	return nil, fmt.Errorf("invalid token")
}

// SayHello implements helloworld.GreeterServer
func (s *server) SayHello(ctx context.Context, in *pb.HelloRequest) (*pb.HelloReply, error) {
	var (
		token *jwt.Token
		err   error
	)

	type UserClaims struct {
		Name string `json:"name"`
		jwt.StandardClaims
	}

	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return nil, grpc.Errorf(codes.Unauthenticated, "valid token required.")
	}

	jwtToken, ok := md["authorization"]
	if !ok {
		return nil, grpc.Errorf(codes.Unauthenticated, "valid token required.")
	}

	token, err = validateToken(jwtToken[0])
	if err != nil {
		return nil, grpc.Errorf(codes.Unauthenticated, err.Error())
	}

	claims, ok := token.Claims.(jwt.MapClaims)

	name, ok := claims["name"].(string)

	if !ok {
		return nil, grpc.Errorf(codes.NotFound, "invalid token payload.")
	}

	return &pb.HelloReply{Message: "Hello " + name}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterGreeterServer(s, &server{})
	// Register reflection service on gRPC server.
	reflection.Register(s)
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
