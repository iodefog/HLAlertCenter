
#import <UIKit/UIKit.h>

@interface UIView (HLCategory)


// DRAW GRADIENT
+ (void) drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors;
+ (void) drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colors;


// DRAW ROUNDED RECTANGLE
+ (void) drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius;

// DRAW LINE
+ (void) drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors;
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap;



CGPoint demoLGStart(CGRect bounds);
CGPoint demoLGEnd(CGRect bounds);
CGPoint demoRGCenter(CGRect bounds);
CGFloat demoRGInnerRadius(CGRect bounds);



@end



