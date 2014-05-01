#include "GameCenter.h"
#include "OCGameCenter.h"

void CGameCenter::Login(){
    [[OCGameCenter shared] login];
}

void CGameCenter::PostScore(const char* idName,int score){
    [[OCGameCenter shared] postScore:idName score:[NSNumber numberWithInt:score]];
}

void CGameCenter::clearAllScores(){
}

void CGameCenter::ShowLeaderboards(){
    [[OCGameCenter shared] showLeaderboard];
}