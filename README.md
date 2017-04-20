**
弱提示弹框,定时消失。分为只显示一个和队列显示

pod 初始化

```objc
pod 'HLAlertCenter'
pod install

```

代码如下
```objc

- (void)postMessage:(NSString *)tip;
- (void)postMessage:(NSString *)tip image:(UIImage *)image;

- (void)postMessage:(NSString *)message origin_y:(float)origin_y;
- (void)postMessage:(NSString *)message image:(UIImage *)image origin_y:(float)origin_y;

```



使用方式:

```objc

    [self postMessage:@"测试测试测试测试测试测试"];
    [self postMessage:@"测试测试测试测试测试测试" image:[UIImage imageNamed:@"SVLoadingView"]];
```

或者 

```objc
    [[HLAlertCenter defaultCenter] postAlertWithMessage:@"测试测试测试测试测试测试"];
    [[HLAlertCenter defaultCenter] postAlertWithMessage:@"测试测试测试测试测试测试"  image:[UIImage imageNamed:@"SVLoadingView"]];

```

效果图如下：
![image](./ScreenShot1.png)
![image](./ScreenShot2.png)



```objc
 [[HLAlertCenter defaultCenter] postMessage:@"测试测试测试测试测试测试" origin_y:0];
 [[HLAlertCenter defaultCenter] postMessage:@"测试测试测试测试测试测试" image:[UIImage imageNamed:@"SVLoadingView"]];

````


或者

```objc
[[HLAlertCenter defaultCenter] postMessage:@"测试测试测试测试测试测试" origin_y:0];
[[HLAlertCenter defaultCenter] postMessage:@"测试测试测试测试测试测试" image:[UIImage imageNamed:@"SVLoadingView"]];


```

效果图如下：
![image](./ScreenShot3.png)
![image](./ScreenShot4.png)
