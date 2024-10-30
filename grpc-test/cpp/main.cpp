
#include "main.grpc.pb.h"
#include <grpcpp/grpcpp.h>
#include <iostream>

int main(){
    auto channel = grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials());
    auto stub = helloworld::Greeter::NewStub(channel);
    grpc::ClientContext context;
    helloworld::HelloRequest request;
    request.set_name("hello");
    helloworld::HelloReply reply;
    grpc::Status status = stub->SayHello(&context, request, &reply);
    if (status.ok()) {
        std::cout << reply.message() << "\n";
    } else {
        std::cout << "Failed\n";
    }
}