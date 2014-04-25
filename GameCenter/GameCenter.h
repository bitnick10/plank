#pragma once

class CGameCenterCaller{
public:
    void Login();
    void PostScore(const char* idName,int score);
    void clearAllScores();
};
