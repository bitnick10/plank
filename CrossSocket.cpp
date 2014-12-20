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
#include "Supervisor.h"
CrossSocket::CrossSocket() {
#ifdef _WIN32
    WORD wVersionRequested;
    WSADATA wsaData;
    wVersionRequested = MAKEWORD(1, 1);
    int iStatus = WSAStartup(wVersionRequested, &wsaData);
    if (iStatus != 0) {
        return ;
    }
    if (LOBYTE(wsaData.wVersion) != 1 ||
            HIBYTE(wsaData.wVersion) != 1) {
        WSACleanup();
        return ;
    }
#endif // _WIN32 

    _socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

    if(_socket == -1) {
        Close();
    }
}

void CrossSocket::Connect(const char* addr, int port) {
    struct sockaddr_in destAddr;
    destAddr.sin_family = AF_INET;
    destAddr.sin_port = htons(port);
#ifdef _WIN32
    destAddr.sin_addr.S_un.S_addr = inet_addr(addr);
#else
    destAddr.sin_addr.s_addr = inet_addr(addr);
#endif
    int errCode = connect(_socket, (sockaddr*)&destAddr, sizeof(destAddr));
    if(errCode < 0) {
        Close();
    }
}
void CrossSocket::Send(const char* data, int len) {
    send(_socket, data, len, 0);
}
void CrossSocket::Close() {
#ifdef _WIN32
    if(_socket != -1) {
        closesocket(_socket);
    }
    WSACleanup();
#else
    if(s != -1) {
        close(s);
    }
#endif
}
