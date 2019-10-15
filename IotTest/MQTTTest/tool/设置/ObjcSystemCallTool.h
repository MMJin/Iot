//
//  ObjcSystemCallTool.h
//  IotTest
//
//  Created by FCNC05 on 2019/8/26.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum:int {
///蓝牙
    Bluetooth =1,
///wifi
    WIFI = 0,
///通用设置
    General =2,
///相机和照片
    Photos = 3,

}systemType;//系统设置
NS_ASSUME_NONNULL_BEGIN
///通过系统调用打开对应的设置页
@interface ObjcSystemCallTool : NSObject

/**
 从App Store上获取app信息

 @param appstoreId appstore上的appId
 */
+(void)systemAppEvaluateE:(NSString *)appstoreId;

/**
打开系统设置
 */
+(void)callSystemSet;
@end

NS_ASSUME_NONNULL_END
