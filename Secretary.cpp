#include "Secretary.h"
#include <chrono>

Secretary_c Secretary;

Secretary_c::Secretary_c() {

}
void Secretary_c::StopwatchReset() {
    start = std::chrono::system_clock::now();
    //auto duration = now.time_since_epoch();
    //auto milliseconds = std::chrono::duration_cast<std::chrono::milliseconds>(duration).count();
}

int64_t Secretary_c::GetMilliseconds() {
    auto now = std::chrono::system_clock::now();
    auto interval = now - start;
    auto milliseconds = std::chrono::duration_cast<std::chrono::milliseconds>(interval).count();
    return milliseconds;
}