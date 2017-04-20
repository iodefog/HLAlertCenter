//
//  ViewController.m
//  HLAlertCenterDemo
//
//  Created by LHL on 2017/4/19.
//  Copyright © 2017年 lihongli. All rights reserved.
//

#import "ViewController.h"
#import "HLAlertCenter.h"
#import "NSObject+HLAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)postMessage1:(id)sender {
    [[HLAlertCenter defaultCenter] postAlertWithMessage:@"测试测试测试测试测试测试"];
//    [self postMessage:@"测试测试测试测试测试测试" origin_y:0];
    [self postMessage:@"测试测试测试测试测试测试"];


}
- (IBAction)postMessage2:(id)sender {
//    [self postMessage:@"测试测试测试测试测试测试" image:[UIImage imageNamed:@"SVLoadingView"] origin_y:0];
    [self postMessage:@"测试测试测试测试测试测试" image:[UIImage imageNamed:@"SVLoadingView"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
