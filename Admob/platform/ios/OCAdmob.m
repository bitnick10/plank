#import "OCAdmob.h"
//#import "AdsWrapper.h"
@interface OCAdmob()

+ (UIViewController *)getCurrentRootViewController;
+ (void) addAdView:(UIView*) view atPos:(AdsPosEnum) pos;

@end

@implementation OCAdmob

@synthesize strPublishID;
@synthesize bannerView;

static OCAdmob* instance = nil;

+ (OCAdmob*)shared
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

+ (void) addAdView:(UIView*) pView atPos:(AdsPosEnum) pos
{
    UIViewController* rootViewController = [OCAdmob getCurrentRootViewController];
    
    if (nil == rootViewController) {
        //PluginUtilsIOS::outputLog("Can't get the UIViewController object");
        return;
    }
    
    CGSize rootSize = rootViewController.view.frame.size;
    CGSize viewSize = pView.frame.size;
    CGPoint viewOrigin;
    
    if (UIInterfaceOrientationIsLandscape(rootViewController.interfaceOrientation)){
        CGFloat temp = rootSize.width;
        rootSize.width = rootSize.height;
        rootSize.height = temp;
    }
    
    switch (pos) {
        case kPosTop:
            viewOrigin.x = (rootSize.width - viewSize.width) / 2;
            viewOrigin.y = 0.0f;
            break;
        case kPosTopLeft:
            viewOrigin.x = 0.0f;
            viewOrigin.y = 0.0f;
            break;
        case kPosTopRight:
            viewOrigin.x = rootSize.width - viewSize.width;
            viewOrigin.y = 0.0f;
            break;
        case kPosBottom:
            viewOrigin.x = (rootSize.width - viewSize.width) / 2;
            viewOrigin.y = rootSize.height - viewSize.height;
            break;
        case kPosBottomLeft:
            viewOrigin.x = 0.0f;
            viewOrigin.y = rootSize.height - viewSize.height;
            break;
        case kPosBottomRight:
            viewOrigin.x = rootSize.width - viewSize.width;
            viewOrigin.y = rootSize.height - viewSize.height;
            break;
        case kPosCenter:
        default:
            viewOrigin.x = (rootSize.width - viewSize.width) / 2;
            viewOrigin.y = (rootSize.height - viewSize.height) / 2;
            break;
    }
    
    CGRect rect = CGRectMake(viewOrigin.x, viewOrigin.y, viewSize.width, viewSize.height);
    pView.frame = rect;
    [rootViewController.view addSubview:pView];
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
- (void) setPublishID:(const char*) id{
	self.strPublishID =[NSString stringWithUTF8String:id];
}
- (void) MoveTo:(double) duration X:(int)x Y:(int) y{
    [UIView animateWithDuration:duration animations:^{
        //self.bannerView.center = CGPointMake(0, 0);
        self.bannerView.bounds = CGRectMake(x, y, self.bannerView.frame.size.width, self.bannerView.frame.size.height);
    }];
}
- (void) showBanner:(int) sizeEnum atPos:(int) pos{
	GADAdSize size = kGADAdSizeBanner;
    switch (sizeEnum) {
        case kSizeBanner:
            size = kGADAdSizeBanner;
            break;
        case kSizeIABMRect:
            size = kGADAdSizeMediumRectangle;
            break;
        case kSizeIABBanner:
            size = kGADAdSizeFullBanner;
            break;
        case kSizeIABLeaderboard:
            size = kGADAdSizeLeaderboard;
            break;
        case kSizeSkyscraper:
            size = kGADAdSizeSkyscraper;
            break;
        default:
            break;
    }
    if (nil != self.bannerView) {
        [self.bannerView removeFromSuperview];
        self.bannerView = nil;
    }
    
    self.bannerView = [[GADBannerView alloc] initWithAdSize:size];
    self.bannerView.adUnitID = self.strPublishID;
    self.bannerView.delegate = self;
    [self.bannerView setRootViewController:[OCAdmob getCurrentRootViewController]];
    [OCAdmob addAdView:self.bannerView atPos:pos];
    
    GADRequest* request = [GADRequest request];
    [self.bannerView loadRequest:request];
}

@end