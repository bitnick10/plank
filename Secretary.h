#pragma once

#include <vector>
#include <chrono>
class Secretary_c{
private:
	std::chrono::time_point<std::chrono::system_clock> now;
public:
	void StopwatchReset();
};

extern Secretary_c Secretary;