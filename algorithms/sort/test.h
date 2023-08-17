#pragma once
#include <vector>

//void bubble_sort(std::vector<int>& values)
using sort_func_ptr = void (*) (std::vector<int>&);

void print_vector(const std::vector<int>&);
void test(sort_func_ptr);