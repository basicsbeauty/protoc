FROM golang:1.20-alpine3.18

# Install required additional tooling
RUN apk --no-cache add git openssh bash zip curl

CMD /bin/bash

RUN curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v23.4/protoc-23.4-linux-x86_64.zip && \
unzip protoc-23.4-linux-x86_64.zip -d $HOME/local && \
cp $HOME/local/bin/protoc /usr/local/bin/protoc && \
mkdir -p /opt/include && \
cp -rf $HOME/local/include/* /opt/include

# Install grpc
# RUN go install google.golang.org/grpc@v1.56.2

# Install protoc go plugin
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.31.0
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

# Install protoc-gen-validate
RUN go install github.com/envoyproxy/protoc-gen-validate@v1.0.2 && \
cp -rf /go/pkg/mod/github.com/envoyproxy/protoc-gen-validate\@v1.0.2/* /opt/include/
