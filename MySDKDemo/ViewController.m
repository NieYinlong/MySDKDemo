//
//  ViewController.m
//  MySDKDemo
//
//  Created by 聂银龙 on 2022/3/22.
//

#import "ViewController.h"
#import <MySDK/MySDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Hud showToast:@"Hello"];
    self.view.backgroundColor = UIColor.grayColor;
}


@end
