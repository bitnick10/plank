#include "Secretary.h"
#include <chrono>

Secretary_c Secretary;

Secretary_c::Secretary_c(){
	
}
void Secretary_c::StopwatchReset(){
	now = std::chrono::system_clock::now();
	auto duration = now.time_since_epoch();
	auto milliseconds = std::chrono::duration_cast<std::chrono::milliseconds>(duration).count();*/
	_crossSocket.Send(str.data(),str.length());
}