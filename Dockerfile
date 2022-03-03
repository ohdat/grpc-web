FROM node:14.18.3

RUN curl -L -o /usr/local/bin/protoc-gen-grpc-web https://github.com/grpc/grpc-web/releases/download/1.31.1/protoc-gen-grpc-web-1.31.1-linux-x86_64
RUN chmod +x /usr/local/bin/protoc-gen-grpc-web

RUN apt-get update && apt-get install yarn

RUN apt-get install curl && \
  mkdir -p /protobuf/google/protobuf && \
    for f in any duration descriptor empty struct timestamp wrappers; do \
      curl -L -o /protobuf/google/protobuf/${f}.proto https://raw.githubusercontent.com/google/protobuf/master/src/google/protobuf/${f}.proto; \
    done && \
  mkdir -p /protobuf/google/api && \
    for f in annotations http; do \
      curl -L -o /protobuf/google/api/${f}.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/master/third_party/googleapis/google/api/${f}.proto; \
    done


RUN yarn global add grpc-tools grpc_tools_node_protoc_ts

ENTRYPOINT ["/usr/local/bin/grpc_tools_node_protoc", "-I/protobuf"]
