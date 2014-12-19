#pragma once

#include <vector>
#include "CrossSocket.h"
class Supervisor_c{
private:
	CrossSocket _crossSocket;
public:
	std::vector<std::string> RecordedError;
	void Tell(const char* data);
};

extern Supervisor_c Supervisor;