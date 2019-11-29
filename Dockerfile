FROM golang:1.13 as swagger
RUN apt-get -y update \
 && apt-get install -y curl ca-certificates make gcc g++ zip npm unzip

ENV GO111MODULE=off
ADD *.zip ./
RUN unzip -o protoc-3.9.1-linux-x86_64.zip -d /usr/local bin/protoc \
 && unzip -o protoc-3.9.1-linux-x86_64.zip -d /usr/local include/* \
 && rm -f *.zip \
 && go get -v -u github.com/golang/protobuf/protoc-gen-go && \
    go get -v -u github.com/amsokol/protoc-gen-gotag && \
    go get -v -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
    go get -v -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger && \
    go get -v -u google.golang.org/grpc && \
    go get -v -u github.com/amsokol/mongo-go-driver-protobuf && \
    go get -v -u github.com/amsokol/protoc-gen-gotag && \
    go get -v -u github.com/go-swagger/go-swagger/... && \
    go install github.com/go-swagger/go-swagger/cmd/swagger && \
    npm install -g redoc-cli

ENV GO111MODULE=auto

WORKDIR /swagger
ENTRYPOINT ["tail", "-f", "/dev/null"]
