#import "substrate.h"
#import <CoreGraphics/CoreGraphics.h>



@interface SBUILegibilityLabel : UIView
@property (nonatomic) long long textAlignment;
-(void)setFrame:(CGRect)frame;
-(void)setTextAlignment:(long long)integer;
@end


@interface SBSearchEtceteraDateViewController {

SBUILegibilityLabel *_dateLabel;

}
-(void)loadView;
@end

@interface SBFLockScreenDateSubtitleView : UIView
@end

@interface SBFLockScreenDateSubtitleDateView : SBFLockScreenDateSubtitleView
@end

@interface SBFLockScreenDateView : UIView {

SBUILegibilityLabel *_timeLabel;
SBFLockScreenDateSubtitleDateView *_dateSubtitleView;
}
-(void)layoutSubviews;
-(void)setAlignmentPercent:(double)arg1;
@end


static SBUILegibilityLabel *dateLabel;
static SBUILegibilityLabel *timeLabel;
static SBFLockScreenDateSubtitleDateView *dateSubtitleView;

%hook SBFLockScreenDateView

-(void)layoutSubviews
  {

%orig;

timeLabel = MSHookIvar<SBUILegibilityLabel *>(self, "_timeLabel");

dateSubtitleView = MSHookIvar<SBFLockScreenDateSubtitleDateView *>(self, "_dateSubtitleView");


}

-(void)setAlignmentPercent:(double)arg1
   {
%orig(1);


}

%end

%hook SBSearchEtceteraDateViewController

-(void)loadView
  {

%orig;

dateLabel = MSHookIvar<SBUILegibilityLabel *>(self, "_dateLabel");
[dateLabel setTextAlignment:1];
}
  
%end

%hook SBUILegibilityLabel
-(void)setFrame:(CGRect)frame
{
     if(self == dateLabel  ||  self == timeLabel)
     {
          CGRect newFrame = frame;
          newFrame.origin.x = frame.origin.x/2;
          return %orig(newFrame);
     }
     
     else
     {
          return %orig;
     }

}


-(void)setTextAlignment:(long long)integer
{
     if(self == dateLabel)
     {
          return %orig(1);
     }
     else
     {
          return %orig;
     }

}

%end


%hook  SBFLockScreenDateSubtitleDateView

-(void)setFrame:(CGRect)frame2
{
   if(self == dateSubtitleView)
     {
          CGRect newFrame2 = frame2;
          newFrame2.origin.x = frame2.origin.x/2;
          return %orig(newFrame2);
     }
     
     else
     {
          return %orig;
     }

}

%end
