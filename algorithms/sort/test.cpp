#include "test.h"
#include <iostream>
#include <vector>

void print_vector(const std::vector<int>& values){
    for (auto elem:values){
        std::cout << elem << " ";
    }
}

void test(sort_func_ptr sort_func){
    std::vector<std::vector<int>> vectors = {
        {9, 8, 7, 6, 5, 4, 3, 2, 1},
        {1, 3, 9, 7, 6, 5, 2, 4, 8},
        {99, 87, 54, 2, 85, 238, 1},
        {54, 46, 11, 12, 4, 6, 7, 5},
        {15, 55, 16, 66, 77, 17, 12, 22, 33, 13, 44, 14}
    };
    std::vector<std::vector<int>> sorted_vectors = {
        {1, 2, 3, 4, 5, 6, 7, 8, 9},
        {1, 2, 3, 4, 5, 6, 7, 8, 9},
        {1, 2, 54, 85, 87, 99, 238},
        {4, 5, 6, 7, 11, 12, 46, 54},
        {12, 13, 14, 15, 16, 17, 22, 33, 44, 55, 66, 77}
    };
    int correct_sorts = 0;
    for (int i = 0; i < vectors.size(); ++i){
        sort_func(vectors[i]);
        print_vector(vectors[i]);
        if(vectors[i] == sorted_vectors[i]){
            std::cout << " [OK]" << std::endl;
            correct_sorts++;
        } else {
            std::cout << " [ERROR]" << std::endl;
        }
    }
    std::cout << "[" << correct_sorts << "/" << vectors.size() << "]" << std::endl;
}