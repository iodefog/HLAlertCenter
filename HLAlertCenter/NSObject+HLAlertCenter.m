#import "NSObject+HLAlertCenter.h"
#import "HLAlertCenter.h"

@implementation NSObject (HLAlertCenter)


- (void)postMessage:(NSString *)tip{
    [[HLAlertCenter defaultCenter] postAlertWithMessage:tip];

}

- (void)postMessage:(NSString *)tip image:(UIImage *)image{
    [[HLAlertCenter defaultCenter] postAlertWithMessage:tip image:image];
}

- (void)postMessage:(NSString *)message origin_y:(float)origin_y{
    [[HLAlertCenter defaultCenter] postAlertWithMessage:message origin_y:origin_y];
}

- (void)postMessage:(NSString *)message image:(UIImage *)image origin_y:(float)origin_y{
    [[HLAlertCenter defaultCenter] postAlertWithMessage:message image:image origin_y:origin_y];
}


@end
