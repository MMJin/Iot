//
//  ObjcSystemCallTool.m
//  IotTest
//
//  Created by FCNC05 on 2019/8/26.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "ObjcSystemCallTool.h"

@implementation ObjcSystemCallTool

+(void)systemAppEvaluateE:(NSString *)appstoreId{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@",appstoreId]] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@",appstoreId]]];
    }
}
///需要设置权限 且之前prefs小写P 现在需要大写 添加url type。：Prefs
+(void)callSystemSet{
    //NSString *prefsStr = [NSString stringWithFormat:@"prefs:root=WIFI"];//IOS 10 弃用
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }

}
@end
