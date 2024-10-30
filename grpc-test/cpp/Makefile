main: main.cpp ../main.proto
	protoc ../main.proto --proto_path="../" --cpp_out="./" --grpc_out="./" --plugin=protoc-gen-grpc=`which grpc_cpp_plugin`
	g++ main.cpp main.pb.cc main.grpc.pb.cc -o app -lprotobuf -lgrpc -labsl_synchronization -lgrpc++

clean:
	rm -f \
		*.grpc.* \
		*.pb.* \
		app