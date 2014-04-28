#include "Admob.h"
#include "OCAdmob.h"

void CAdmob::setPublishID(const char* id){
    [[OCAdmob shared] setPublishID:id];
}
void CAdmob::showBanner(int sizeEnum,int pos){
    [[OCAdmob shared] showBanner:sizeEnum atPos:pos];
}
void CAdmob::MoveTo(double duration,int x,int y){
    [[OCAdmob shared] MoveTo:duration X:x Y:y];
}