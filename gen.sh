#!/usr/bin/env sh

export GOPATH="$GOPATH":"$PWD/go"
protoc -I ./protobuf --go_out=plugins=grpc:./go/src/greeter_proto ./protobuf/greeter.proto
go build greeter_proto
go install greeter_server
go install greeter_client
(cd backend ; bundle exec grpc_tools_ruby_protoc -I ../protobuf --ruby_out=./lib/ --grpc_out=./lib/ ../protobuf/greeter.proto )
