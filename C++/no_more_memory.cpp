#include <iostream>

void noMoreMemory(){
}

int main(){
    std::set_new_handler(noMoreMemory);
    int *p = new int[10000000000];
    std::cout << "OK\n";
}