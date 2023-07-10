#include <iostream>
#include <string>
#include <tuple>
#include <vector>
#include <map>
#include <mutex>
#include <memory>


struct employee{
    unsigned id;
    std::string name;
    std::string role;
    unsigned salary;

    employee(unsigned id, std::string name, std::string role, unsigned salary){
        this->id = id;
        this->name = name;
        this->role = role;
        this->salary = salary;
    }
};

std::pair<int, int> get_two_int(){
    return std::make_pair(1,2);
}

std::tuple<int, char, std::string> get_tuple(){
    return {1, 'c', "abc"};
}

int main(){
    // структурные привязки
    auto [a, b] = get_two_int();
    std::cout << a << " " << b << std::endl;
    
    auto [n, c, str] = get_tuple();
    std::cout << n << " " << c << " " << str << std::endl;

    employee piter{1, "piter", "coder", 100}, vladimir{2, "vladimir", "coder", 200};
    std::vector<employee> employees {piter, vladimir};
    for (const auto &[id, name, role, salary] : employees){
        std::cout   << "Name: " << name << " "
                    << "Role: " << role << " "
                    << "Salary: " << salary << "\n";
    }

    char arr[]{'h', 'e', 'l', 'l', 'o'};
    auto [item_one, item_two, item_three, item_four, item_five] = arr;
    std::cout << item_one << item_two << item_three << item_four << item_five << std::endl;
    
    std::map<std::string, size_t> animal_population{
        {"chickens", 17863376000},
        {"camels", 24246291},
        {"sheep", 1086881528}
    };
    for (const auto &[species, count] : animal_population) {
        std::cout << "There are " << count << " " << species << " on this planet.\n";
    }

    // до появления С++17 - std::tie. Преимущество: std::ignore; 
    // минус: надо объявлять переменные взаранее
    std::pair<int, int> test{1,2};
    int test_int;
    std::tie(std::ignore, test_int) = test;
    std::cout << test_int << std::endl;

    // инициализация переменных в if и switch; ограниченная область видимости
    if (auto itr {animal_population.find("chickens")}; itr != animal_population.end()){
        std::cout << itr->first << ": " << itr->second << std::endl;
    }
    std::cout << "введите символ: ";
    switch (char c {static_cast<char>(getchar())}; c){
        case 'w': std::cout << "move up" << std::endl; break;
        case 'a': std::cout << "move left" << std::endl; break;
        case 's': std::cout << "move down" << std::endl; break;
        case 'd': std::cout << "move right" << std::endl; break;
        case '0'...'9': std::cout << "select tool " << c -'0' << std::endl;
        default: std::cout << "invalid input" << std::endl;
    }
    // здесь переменная с уже не доступна
    // такая область видимости может быть полезна, чтобы автоматически освободить мьютекс
    std::mutex my_mutex;
    if (std::lock_guard<std::mutex> lg {my_mutex}; 2 > 1) {
        //делаем что-нибудь
    }
    // тоже для умных указателей
    std::vector<int> *vec = new std::vector<int>{1,2,3};
    if (std::shared_ptr<std::vector<int>> shared_pointer {vec}; shared_pointer != nullptr){
        // объект живет
    } else {
        // к указателю можно получить доступ, но он нулевой
    }
    // к shared_pointer нельзя получить доступ
    // полезно для работы с устаревшими API
    // if (DWORD exit_code; GetExitCodeProcess(process_handle, &exit_code)) {
    //      std::cout << "Exit code of process was: " << exit_code << '\n';
    // }
    return 0;
}