#!/usr/bin/env sh

protoc -I ./protobuf --go_out=plugins=grpc:./go/src/greeter_proto ./protobuf/greeter.proto
