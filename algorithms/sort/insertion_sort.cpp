#include <iostream>
#include <vector>
#include "test.h"

void comb_sort(std::vector<int>& values){
    constexpr double factor = 1.247; //Фактор уменьшения
    double step = values.size() - 1;

    while (step >= 1){
        for (int i = 0; i + step < values.size(); ++i){
            if (values[i] > values[i+step]){
                std::swap(values[i], values[i+step]);
            }
        }
        step /= factor;
    }
}

int main(){
    test(comb_sort);
    return 0;
}

/*


Худшее время: O(n^2)
Среднее время: Ω(n^2 / 2^p), где p - количество инкрементов
Лучшее время: O(n log n)

Затраты памяти: O(1)
*/