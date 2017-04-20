#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HLAlertShowDefault,
    HLAlertShowQueue,
} HLAlertShowType;

@class HLAlertView;
@interface HLAlertCenter : NSObject {
	NSMutableArray *_alerts;
	BOOL _active;
	HLAlertView *_alertView;
	CGRect _alertFrame;
    BOOL    isRect;
}

@property (nonatomic, assign) float origin_y;
@property (nonatomic, assign) HLAlertShowType alertShowType;

+ (HLAlertCenter*) defaultCenter;
- (void) postAlertWithMessage:(NSString*)message image:(UIImage*)image;
- (void) postAlertWithMessage:(NSString *)message;
- (void) postAlertWithMessage:(NSString *)message origin_y:(float)origin_y;
- (void) postAlertWithMessage:(NSString *)message image:(UIImage *)image origin_y:(float)origin_y;
@end
