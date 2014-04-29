#pragma once

class CGameCenter{
public:
    void Login();
    void PostScore(const char* idName,int score);
    void DisplayLeaderboards();
    void clearAllScores();
};
