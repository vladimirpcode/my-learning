#include <iostream>
#include <thread>
#include <mutex>

using namespace std;

int count1 = 0;
int count2 = 0;
recursive_mutex m;

void threadFunc()
{
    for(int i = 0; i < 50; i++)
    {
        cout << "trying..." << endl;
        m.lock();
        count1++;
        m.lock();
        count2++;
        cout << "count1 = " << count1 << " count2 = " << count2 << endl;
        m.unlock();
        m.unlock();
    }
}

int main()
{
    thread t1(threadFunc);
    thread t2(threadFunc);
    t1.join();
    t2.join();
    return 0;
}