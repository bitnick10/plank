#pragma once

#include <vector>
#include "CrossSocket.h"

class Supervisor_c {
private:
    CrossSocket _crossSocket;
    bool _isConnected ;
public:
    Supervisor_c();
    std::vector<std::string> RecordedError;
    void Tell(std::string str);
    void Tell(float f);
};

extern Supervisor_c Supervisor;