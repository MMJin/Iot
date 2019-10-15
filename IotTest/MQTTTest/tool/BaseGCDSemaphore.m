//
//  BaseGCDSemaphore.m
//  IotTest
//
//  Created by FCNC05 on 2019/8/19.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "BaseGCDSemaphore.h"
@interface BaseGCDSemaphore()
///信号量
@property(nonatomic,strong)dispatch_semaphore_t sem;
@end
@implementation BaseGCDSemaphore
//初始化
-(instancetype)initWithSelectorNmaeArr:(NSArray *)selectorNmaeArr withObject:(id)object withResult:(SemResult)result{
    if (self = [super init]) {
        //初始化
        self.result = result;
        self.object = object;
        self.selectorNmaeArr = selectorNmaeArr;
        self.sem = dispatch_semaphore_create(0);
        [self splitSelectorArr:self.selectorNmaeArr];
    }
    return self;
}
//拆分数组生成方法 调用
-(void)splitSelectorArr:(NSArray *)selectorArr{
    //需要创建线程组
   __weak typeof(self)weakSelf = self;
    dispatch_group_t semGroup = dispatch_group_create();
    for (NSString *selectorName in selectorArr) {
        SEL selector = NSSelectorFromString(selectorName);
        if (self.object){
            if ([self.object respondsToSelector:selector]){
                dispatch_group_async(semGroup,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.object performSelector:selector withObject:nil afterDelay:0];
                     dispatch_semaphore_wait(weakSelf.sem, DISPATCH_TIME_FOREVER);
                });
            }
        }
    }
    //监听线程组全部完成
    dispatch_group_notify(semGroup, dispatch_get_main_queue(), ^{
        self.result(@"1");
    });
}
///
-(void)semFinish{
    dispatch_semaphore_signal(self.sem);
}
@end
