#!/bin/sh

openssl req -nodes -newkey rsa:4096 -keyout keys/go_greeter.key -out keys/go_greeter.crt -x509 -days 365

