#ifdef _WIN32
#include <WinSock2.h>
#pragma comment(lib, "ws2_32.lib") 
#else
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#endif

#include "CrossSocket.h"
CrossSocket::CrossSocket(){
#ifdef _WIN32  
	WORD wVersionRequested;  
	WSADATA wsaData;  
	wVersionRequested = MAKEWORD(1, 1);  
	int iStatus = WSAStartup(wVersionRequested, &wsaData);  
	if (iStatus != 0) {  
		return 0;  
	}  
	if (LOBYTE(wsaData.wVersion) != 1 ||  
		HIBYTE(wsaData.wVersion) != 1) {  
			WSACleanup();  
			return 0;  
	}  
#endif // _WIN32 
	struct sockaddr_in destAddr;
	destAddr.sin_family = AF_INET;
	destAddr.sin_port = htons(11000);
#ifdef _WIN32
	destAddr.sin_addr.S_un.S_addr = inet_addr("192.168.1.170");
#else
	destAddr.sin_addr.s_addr= inet_addr("192.168.1.170");
#endif

	int s = socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);

	if(s == -1){
		CCLOG("error crete socket GetLastError() = %d\n",GetLastError());
		goto tcpEnd;
	}

	int errCode = connect(s,(sockaddr*)&destAddr,sizeof(destAddr));
	if(errCode<0){
		CCLOG("error connect GetLastError() = %d\n",GetLastError());
		goto tcpEnd;
	}
	while(true){
		send(s,"109",3,0);
	}
tcpEnd:
#ifdef _WIN32  
	if(s != -1){
		closesocket(s);  
	}
	WSACleanup();  
#else
	if(s != -1){
		close(s);  
	}
#endif  
	return true;
}