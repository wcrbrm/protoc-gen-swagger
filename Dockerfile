FROM golang:1.12 as swagger
RUN apt-get -y update \
 && apt-get install -y curl ca-certificates make gcc g++ zip

ADD *.zip ./
RUN unzip -o protoc-3.9.1-linux-x86_64.zip -d /usr/local bin/protoc \
 && unzip -o protoc-3.9.1-linux-x86_64.zip -d /usr/local include/* \
 && rm -f *.zip \
 && go get -u github.com/golang/protobuf/protoc-gen-go \
 && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger \
 && go get -u google.golang.org/grpc \
 && go get -u github.com/amsokol/protoc-gen-gotag

WORKDIR /swagger
ENTRYPOINT ["tail", "-f", "/dev/null"]
