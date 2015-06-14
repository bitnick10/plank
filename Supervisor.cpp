#include "Supervisor.h"

#include <string>
#include <stdarg.h>
Supervisor_c Supervisor;

Supervisor_c::Supervisor_c() {
    _isConnected = false;
}
void Supervisor_c::Tell(std::string str) {
    if(!_isConnected) {
        _crossSocket.Connect("192.168.1.170", 11000);
        _isConnected = true;
    }
    /*auto now = std::chrono::system_clock::now();
    auto duration = now.time_since_epoch();
    auto milliseconds = std::chrono::duration_cast<std::chrono::milliseconds>(duration).count();*/
    _crossSocket.Send(str.data(), str.length());
}
void Supervisor_c::Tell(float f) {
    Tell(std::to_string(f));
}
