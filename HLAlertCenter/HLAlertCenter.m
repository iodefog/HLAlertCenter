#import "HLAlertCenter.h"
#import "UIView+HLCategory.h"

@interface HLAlertCenter()
@property (nonatomic, strong) NSMutableArray *alerts;
@end


@interface HLAlertView : UIView {
	CGRect messageRect;
	NSString *text;
	UIImage *image;
}

- (id) init;
- (void) setMessageText:(NSString*)str;
- (void) setImage:(UIImage*)image;

@end



@implementation HLAlertCenter
@synthesize alerts;

+ (HLAlertCenter*) defaultCenter {
	static HLAlertCenter *defaultCenter = nil;
	if (!defaultCenter) {
		defaultCenter = [[HLAlertCenter alloc] init];
	}
	return defaultCenter;
}

- (id) init{
	if(!(self=[super init])) return nil;
	
	self.alerts = [NSMutableArray array];
	_alertView = [[HLAlertView alloc] init];
	_active = NO;
	
	
	_alertFrame = [UIApplication sharedApplication].keyWindow.bounds;
    
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardDidHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationWillChange:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    
	return self;
}

- (void) showAlerts{
	
	if([self.alerts count] < 1) {
		_active = NO;
		return;
	}
   
	_active = YES;
	
	_alertView.transform = CGAffineTransformIdentity;
	_alertView.alpha = 0;
	[[UIApplication sharedApplication].keyWindow addSubview:_alertView];
    
	
	
	NSArray *ar = [self.alerts objectAtIndex:0];
	
	UIImage *img = nil;
	if([ar count] > 1) img = [[self.alerts objectAtIndex:0] objectAtIndex:1];
	
	[_alertView setImage:img];
    
	if([ar count] > 0) [_alertView setMessageText:[[self.alerts objectAtIndex:0] objectAtIndex:0]];
	
	
	
//	_alertView.center = CGPointMake(_alertFrame.origin.x+_alertFrame.size.width/2, 480-90);//alertFrame.origin.y+alertFrame.size.height/2);
//    
//	
//	CGRect rr = _alertView.frame;
//	rr.origin.x = (int)rr.origin.x;
//	rr.origin.y = (int)rr.origin.y;
//	_alertView.frame = rr;
    
    _alertView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
	
//	UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
	CGFloat degrees = 0;
//	if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
//	else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
//	else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
	_alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	_alertView.transform = CGAffineTransformScale(_alertView.transform, 2, 2);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.15];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationStep2)];
	
	_alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	_alertView.frame = CGRectMake((int)_alertView.frame.origin.x, (int)_alertView.frame.origin.y, _alertView.frame.size.width, _alertView.frame.size.height);
	_alertView.alpha = 1;
	if (isRect) {
        CGRect frame = _alertView.frame;
        frame.origin.y = self.origin_y;
        _alertView.frame = frame;
    }
	[UIView commitAnimations];
	
	
}
- (void) animationStep2{
	[UIView beginAnimations:nil context:nil];
    
	// depending on how many words are in the text
	// change the animation duration accordingly
	// avg person reads 200 words per minute
	NSArray * words = [[[self.alerts objectAtIndex:0] objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	double duration = MAX(((double)[words count]*60.0/200.0),1);
	
	[UIView setAnimationDelay:duration + 1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationStep3)];
	
//	UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
	CGFloat degrees = 0;
//	if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
//	else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
//	else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
	_alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	_alertView.transform = CGAffineTransformScale(_alertView.transform, 0.5, 0.5);
	
	_alertView.alpha = 0;
	[UIView commitAnimations];
}

- (void) animationStep3{
	
	[_alertView removeFromSuperview];
	[alerts removeObjectAtIndex:0];
	[self showAlerts];
	
}

- (void) postAlertWithMessage:(NSString*)message image:(UIImage*)image{
    
    if (self.alertShowType == HLAlertShowQueue) {
        [self.alerts addObject:[NSArray arrayWithObjects:message,image,nil]];
        if(!_active) [self showAlerts];
    }
    else {
//        [_alertView removeFromSuperview];
        [self.alerts removeAllObjects];
        
        [self.alerts addObject:[NSArray arrayWithObjects:message,image,nil]];
        if(!_active) [self showAlerts];
    }
    isRect = NO;
}

- (void) postAlertWithMessage:(NSString*)message{
	[self postAlertWithMessage:message image:nil];
}

- (void) postAlertWithMessage:(NSString *)message  origin_y:(float)origin_y{
    [self postAlertWithMessage:message image:nil origin_y:origin_y];
}

- (void) postAlertWithMessage:(NSString *)message image:(UIImage *)image origin_y:(float)origin_y{
    self.origin_y = origin_y;
    isRect = YES;
    [self postAlertWithMessage:message image:image];
}


CGRect subtractRect(CGRect wf,CGRect kf){
	
	
	
	if(!CGPointEqualToPoint(CGPointZero,kf.origin)){
		
		if(kf.origin.x>0) kf.size.width = kf.origin.x;
		if(kf.origin.y>0) kf.size.height = kf.origin.y;
		kf.origin = CGPointZero;
		
	}else{
		
		
		kf.origin.x = fabs(kf.size.width - wf.size.width);
		kf.origin.y = fabs(kf.size.height -  wf.size.height);
		
		
		if(kf.origin.x > 0){
			CGFloat temp = kf.origin.x;
			kf.origin.x = kf.size.width;
			kf.size.width = temp;
		}else if(kf.origin.y > 0){
			CGFloat temp = kf.origin.y;
			kf.origin.y = kf.size.height;
			kf.size.height = temp;
		}
		
	}
	return CGRectIntersection(wf, kf);
	
	
	
}

- (void) keyboardWillAppear:(NSNotification *)notification {
	
	NSDictionary *userInfo = [notification userInfo];
	NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	
	//NSValue* aValue = [userInfo objectForKey:UIKeyboardBoundsUserInfoKey];
	
	CGRect kf = [aValue CGRectValue];
	CGRect wf = [UIApplication sharedApplication].keyWindow.bounds;
	
	[UIView beginAnimations:nil context:nil];
	_alertFrame = subtractRect(wf,kf);
	_alertView.center = CGPointMake(_alertFrame.origin.x+_alertFrame.size.width/2, _alertFrame.origin.y+_alertFrame.size.height/2);
    
	[UIView commitAnimations];
    
}
- (void) keyboardWillDisappear:(NSNotification *) notification {
	_alertFrame = [UIApplication sharedApplication].keyWindow.bounds;
    
}
- (void) orientationWillChange:(NSNotification *) notification {
	
    
	NSDictionary *userInfo = [notification userInfo];
	NSNumber *v = [userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey];
	UIInterfaceOrientation o = [v intValue];
	
    CGFloat height = MAX(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    CGFloat width = MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));

    switch (o) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            _alertView.center = CGPointMake(height/2, width/2);
            break;
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            _alertView.center = CGPointMake(width/2, height/2);

        default:
            break;
    }
	
	
//	CGFloat degrees = 0;
//	if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
//	else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
//	else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
//	
//	[UIView beginAnimations:nil context:nil];
//	_alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
//	_alertView.frame = CGRectMake((int)_alertView.frame.origin.x, (int)_alertView.frame.origin.y, (int)_alertView.frame.size.width, (int)_alertView.frame.size.height);
//    
//	[UIView commitAnimations];
	
}

@end

@implementation HLAlertView

- (id) init{
	
	if(!(self = [super initWithFrame:CGRectMake(0, 0, 100, 100)])) return nil;
	
	messageRect = CGRectInset(self.bounds, 10, 10);
	self.backgroundColor = [UIColor clearColor];
	
	return self;
	
}
- (void) adjust{
	
    CGSize s = CGSizeZero;
    if (text) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:text
                                                                            attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSParagraphStyleAttributeName:paragraph}];
        CGSize labelsize = [attributeText boundingRectWithSize:CGSizeMake(160,200)
                                                       options:NSStringDrawingUsesLineFragmentOrigin |
                            NSStringDrawingUsesFontLeading context:nil].size;
        s = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
    }
	
	float imageAdjustment = 0;
	if (image) {
		imageAdjustment = 7+image.size.height;
	}
	
	self.bounds = CGRectMake(0, 0, s.width+40, s.height+15+15+imageAdjustment);
	
	messageRect.size = s;
	messageRect.size.height += 5;
	messageRect.origin.x = 20;
	messageRect.origin.y = 15+imageAdjustment;
    
	[self setNeedsLayout];
	[self setNeedsDisplay];
	
}
- (void) setMessageText:(NSString*)str{
	text = str;
	[self adjust];
}
- (void) setImage:(UIImage*)img{
	image = img;
	
	[self adjust];
}
- (void) drawRect:(CGRect)rect{
	[[UIColor colorWithWhite:0 alpha:0.8] set];
	[UIView drawRoundRectangleInRect:rect withRadius:10];
	[[UIColor whiteColor] set];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *params = @{
                             NSFontAttributeName:[UIFont boldSystemFontOfSize:14] ,
                             NSParagraphStyleAttributeName:paragraph,
                             NSForegroundColorAttributeName:[UIColor whiteColor]
                             };
    [text drawInRect:messageRect withAttributes:params];
    
	CGRect r = CGRectZero;
	r.origin.y = 15;
	r.origin.x = (rect.size.width-image.size.width)/2;
	r.size = image.size;
	
	[image drawInRect:r];
}

@end
