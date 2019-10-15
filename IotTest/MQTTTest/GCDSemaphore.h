//
//  GCDSemaphore.h
//  IotTest
//
//  Created by FCNC05 on 2019/8/19.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^test)(NSString *test1Str);
@interface GCDSemaphore : NSObject
@property(nonatomic,copy)test test11;
@property(nonatomic,copy)test test22;
@property(nonatomic,copy)test test33;
//需要调用方法的对象（唯一） 和方法（数组-转方法）返回一个总的处理结果
-(void)initSemRequest;
@end

NS_ASSUME_NONNULL_END
