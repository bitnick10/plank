#pragma once

#include <vector>
#include <chrono>
class Secretary_c {
private:
    std::chrono::time_point<std::chrono::system_clock> start;
public:
    Secretary_c();
    void StopwatchReset();
    int64_t GetMilliseconds();
};

extern Secretary_c Secretary;