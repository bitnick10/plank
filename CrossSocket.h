#pragma once
class CrossSocket{
private:
	int _socket;
public:
	CrossSocket();
	void Connect(const char* addr,int port);
	void Send(const char* data);
	void Close();
};