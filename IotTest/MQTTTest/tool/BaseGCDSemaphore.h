//
//  BaseGCDSemaphore.h
//  IotTest
//
//  Created by FCNC05 on 2019/8/19.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SemResult)(NSString *result);
@interface BaseGCDSemaphore : NSObject
///方法数组需要拆分 需要缓存f一份
@property(nonatomic,strong)NSArray *selectorNmaeArr;
///执行对象要缓存一份
@property(nonatomic,weak)id object;
///结果block
@property(nonatomic,copy)SemResult result;
//需要返回结果block 需要方法数组 需要执行对象
-(instancetype)initWithSelectorNmaeArr:(NSArray *)selectorNmaeArr withObject:(id)object withResult:(SemResult)result;
//split拆分数组生成方法
-(void)splitSelectorArr:(NSArray *)selectorArr;
///finish 信号通知
-(void)semFinish;
@end

NS_ASSUME_NONNULL_END
