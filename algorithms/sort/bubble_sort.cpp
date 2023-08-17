#include <iostream>
#include <vector>
#include "test.h"

void bubble_sort(std::vector<int>& values){
    for (int i = 0; i + 1 < values.size(); ++i){
        for (int j = 0; j + 1 < values.size() - i; ++j){
            if (values[j] > values[j + 1]){
                std::swap(values[j], values[j+1]);
            }
        }
    }
}

int main(){
    test(bubble_sort);
    return 0;
}

/*
Худшее время: O(n^2)
Среднее время: O(n^2)
Лучшее время: O(n)

Затраты памяти: O(1)
*/