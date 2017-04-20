#import <UIKit/UIKit.h>

@interface NSObject (HLAlertCenter)

- (void)postMessage:(NSString *)tip;
- (void)postMessage:(NSString *)tip image:(UIImage *)image;

- (void)postMessage:(NSString *)message origin_y:(float)origin_y;
- (void)postMessage:(NSString *)message image:(UIImage *)image origin_y:(float)origin_y;


@end
