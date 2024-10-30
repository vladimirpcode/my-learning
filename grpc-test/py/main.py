from main_pb2_grpc import *
from main_pb2 import *
from grpc import * 
from concurrent import futures

class GreeterServiceImpl(GreeterServicer):
    def SayHello(self, request, context):
        result = {'message': "Hello programer!"}

        return HelloReply(**result)

def main():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    add_GreeterServicer_to_server(GreeterServiceImpl(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    server.wait_for_termination()

main()