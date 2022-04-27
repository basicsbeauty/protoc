FROM golang:1.17-alpine

# Install required additional tooling
RUN apk --no-cache add git protobuf make protobuf-dev
RUN apk --no-cache add openssh
RUN apk --no-cache add bash zip

CMD /bin/bash

# Install grpc
RUN go get -u google.golang.org/grpc@v1.46.0

# Install protoc go plugin
RUN go get -u google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.0

# Install protoc-gen-validate
RUN go get -d github.com/envoyproxy/protoc-gen-validate@v0.6.7 &&\
    cd $GOPATH/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.7 &&\
    make build

# create alias
RUN alias protoc='protoc -I=./ -I="/go/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.7"'
