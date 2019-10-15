//
//  RequestToolManager.h
//  IotTest
//
//  Created by FCNC05 on 2019/8/27.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestToolManager;
typedef void(^SuccessBlock)(id _Nonnull responseObject);
typedef void(^FailBlock)(id _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface RequestToolManager : NSObject
+ (instancetype)shareManager;
//开始网络请求
//-(void)requestWithApi:(NSString *)api parameter:(NSDictionary *)parameter isPost:(BOOL)isPost withSuccess:(SuccessBlock)success withFail:(FailBlock)fail;
-(void)requestWithUser:(NSString *)api parameter:(NSDictionary *)parameter getTargetModel:(id)targetModel isPost:(BOOL)isPost withSuccess:(SuccessBlock)success withFail:(FailBlock)fail;
@end

NS_ASSUME_NONNULL_END
