//
//  Hud.m
//  MySDK
//
//  Created by 聂银龙 on 2022/3/22.
//

#import "Hud.h"
#import <SVProgressHUD.h>

@implementation Hud

- (void)showToast:(NSString *)msg {
    [SVProgressHUD showInfoWithStatus:msg];
}

@end
