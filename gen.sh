#!/usr/bin/env sh

protoc -I ./protobuf --go_out=plugins=grpc:./protobuf ./protobuf/greeter.proto
