@echo off

protoc.exe  -o protocol.pb protocol.proto
protoc.exe  -o login.pb login.proto
protoc.exe 	-o lobby.pb lobby.proto
protoc.exe  -o match.pb match.proto
protoc.exe 	-o private.pb private.proto

echo finished