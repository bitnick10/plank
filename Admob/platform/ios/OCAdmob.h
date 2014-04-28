#pragma once
#import <Foundation/Foundation.h>
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"

typedef enum {
    kPosCenter = 0,
	kPosTop,
	kPosTopLeft,
	kPosTopRight,
	kPosBottom,
	kPosBottomLeft,
	kPosBottomRight,
} AdsPosEnum;

typedef enum {
    kSizeBanner = 1,
    kSizeIABMRect,
    kSizeIABBanner,
    kSizeIABLeaderboard,
    kSizeSkyscraper,
} AdmobSizeEnum;

@interface OCAdmob : NSObject<GADBannerViewDelegate>
{
    
}

+ (OCAdmob*)shared;

@property (copy, nonatomic) NSString* strPublishID;
@property (retain, nonatomic) GADBannerView* bannerView;

- (void) setPublishID:(const char*) id;
- (void) showBanner:(int) sizeEnum atPos:(int) pos;
- (void) MoveTo:(double) duration X:(int)x Y:(int) y;

@end