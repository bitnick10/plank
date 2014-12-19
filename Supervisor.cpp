#include "Supervisor.h"

static Supervisor_c Supervisor;

void Supervisor_c::Tell(const char* data){
	_crossSocket.Connect("192.168.1.170",11000);
	_crossSocket.Send(data);
}