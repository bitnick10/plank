
@interface OCGameCenter : NSObject
{
}

+ (OCGameCenter*)shared;

- (void)login;
- (void)postScore:(const char*)idName score:(NSNumber*)score;
- (void)clearAllScores;
- (void)showLeaderboard;

@end