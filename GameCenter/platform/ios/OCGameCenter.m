#import <GameKit/GameKit.h>
#import "OCGameCenter.h"

@interface OCGameCenter()

+ (UIViewController *)getCurrentRootViewController;
- (void) gameCenterViewControllerDidFinish:(GKGameCenterViewController*) gameCenterViewController;

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
+ (UIViewController *)getCurrentRootViewController {
    
    UIViewController *result = nil;
    
    // Try to find the root view controller programmically
    
    // Find the top window (that is not an alert view or other window)
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"Could not find a root view controller.");
    
    return result;
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
- (void) gameCenterViewControllerDidFinish:(GKGameCenterViewController*) gameCenterViewController{
    UIViewController* rootViewController = [OCGameCenter getCurrentRootViewController];
    [rootViewController dismissViewControllerAnimated:YES completion:nil];
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
    GKScore* scoreReporter = [[GKScore alloc] init];
    scoreReporter.leaderboardIdentifier = [NSString stringWithUTF8String:idName];
    //gkScore.category = [NSString stringWithUTF8String:idName];
    scoreReporter.value = [score longLongValue];
    scoreReporter.shouldSetDefaultLeaderboard = YES;
    
    if (![GKLocalPlayer localPlayer].isAuthenticated) {
        return;
    }
    [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError* error){
        if (error) {
            NSLog(@"[GameCenter] postScore for %s failed: %@", idName, error.localizedDescription);
        }
    }];
    UIViewController* rootViewController = [OCGameCenter getCurrentRootViewController];
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if(gameCenterController!=nil){
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.gameCenterDelegate = self;
        [rootViewController presentViewController:gameCenterController animated:YES completion:nil];
        //viewController.category =[NSString stringWithUTF8String:"thebestscore"];
        //[rootViewController presentedViewController:viewController];
        //[rootViewController.view addSubview:viewController];
    }

}

@end
