#pragma once

enum class AdsPos{
    kPosCenter = 0,
	kPosTop,
	kPosTopLeft,
	kPosTopRight,
	kPosBottom,
	kPosBottomLeft,
	kPosBottomRight,
};

enum class AdmobSize{
    kSizeBanner = 1,
    kSizeIABMRect,
    kSizeIABBanner,
    kSizeIABLeaderboard,
    kSizeSkyscraper,
} ;

class CAdmob {
public:
    void setPublishID(const char* id);
    void showBanner(int sizeEnum,int pos);
    void MoveTo(double duration,int x,int y);
};