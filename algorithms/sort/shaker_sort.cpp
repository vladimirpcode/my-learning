#include <iostream>
#include <vector>
#include "test.h"

void shaker_sort(std::vector<int>& values){
    if (values.empty()){
        return;
    }
    int left = 0;
    int right = values.size() - 1;
    while (left <= right){
        // есть ли разница в какую сторону идти?
        for (int i = left; i < right; ++i){
            if (values[i] > values[i+1]){
                std::swap(values[i], values[i+1]);
            }
        }
        right--;
        for (int i = right; i > left; --i){
            if (values[i-1] > values[i]){
                std::swap(values[i-1], values[i]);
            }
        }
        left++;
    }
}

int main(){
    test(shaker_sort);
    return 0;
}

/*
Шейкерная сортировка отличается от пузырьковой тем,
что она двунаправленная: алгоритм перемещается не строго 
слева направо, а сначала слева направо, затем справа налево.

Худшее время: O(n^2)
Среднее время: O(n^2)
Лучшее время: O(n)

Затраты памяти: O(1)
*/