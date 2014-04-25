#import <GameKit/GameKit.h>
#import "OCGameCenter.h"

@interface OCGameCenter()

@end

@implementation OCGameCenter

static OCGameCenter* instance = nil;

+ (OCGameCenter*)shared
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

- (void)login
{
    GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
    if (localPlayer.isAuthenticated) {
        return;
    }
    
    [localPlayer authenticateWithCompletionHandler:^(NSError* error) {
        if (error) {
            if (error.code != GKErrorAuthenticationInProgress) {
                NSLog(@"[GameCenter] login failed: %@", error.localizedDescription);
            }
        } else {

        }
    }];
}

- (void)clearAllScores
{
    // clear cached scores
    ////NSString* savePath = [self getGameCenterSavePath:scoresArchiveKey];
    //NSError* error = nil;
    //[[NSFileManager defaultManager] removeItemAtPath:savePath error:&error];
    
    // clear remote scores
    //NSLog(@"[GameCenter] WARNING! clearAllScores is not supported on this platform");
}

- (void)postScore:(const char*)idName score:(NSNumber*)score;
{
    GKScore* gkScore = [[GKScore alloc] init];
    gkScore.category = [NSString stringWithUTF8String:idName];
    gkScore.value = [score longLongValue];
    gkScore.shouldSetDefaultLeaderboard = YES;
    
    if (![GKLocalPlayer localPlayer].isAuthenticated) {
        return;
    }
    
    [gkScore reportScoreWithCompletionHandler:^(NSError* error) {
        if (error) {
            NSLog(@"[GameCenter] postScore for %s failed: %@", idName, error.localizedDescription);
        }
    }];
}

@end
