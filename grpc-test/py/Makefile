main: main.py ../main.proto
	protoc ../main.proto --proto_path="../" --python_out="./" --grpc_python_out="./" --plugin=protoc-gen-grpc_python=`which grpc_python_plugin`
	
clean:
	rm -f *pb2*.py