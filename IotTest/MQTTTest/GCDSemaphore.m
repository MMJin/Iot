//
//  GCDSemaphore.m
//  IotTest
//
//  Created by FCNC05 on 2019/8/19.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "GCDSemaphore.h"
@interface GCDSemaphore()
@property(nonatomic,strong)dispatch_semaphore_t sem;

@property(nonatomic,copy)NSString *s;
@end
@implementation GCDSemaphore
-(void)testGCDSemRequest {
    __weak typeof(self)weakSelf = self;
    //创建请求组
     dispatch_group_t semGroup = dispatch_group_create();
    //创建请求线程
    dispatch_group_async(semGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//线程一
        self.test11 = ^(NSString * _Nonnull test1Str) {
            NSLog(@"所有数据请求完成%@",test1Str);
        };
        [self test1];
        dispatch_semaphore_wait(weakSelf.sem, DISPATCH_TIME_FOREVER);
    });

    dispatch_group_async(semGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//线程二
        self.test33 = ^(NSString * _Nonnull test1Str) {
            NSLog(@"所有数据请求完成%@",test1Str);
        };
        [self test3];
        dispatch_semaphore_wait(weakSelf.sem, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(semGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//线程三
        self.test22 = ^(NSString * _Nonnull test1Str) {
          NSLog(@"所有数据请求完成%@",test1Str);
          };
         [self test2];
         dispatch_semaphore_wait(weakSelf.sem, DISPATCH_TIME_FOREVER);
    });
    //监听线程组全部完成
    dispatch_group_notify(semGroup, dispatch_get_main_queue(), ^{
        NSLog(@"所有数据请求完成可以刷新主界面了");
    });
}

-(void)test1{
    for (int i = 0; i < 30 ; i++) {
        if (i == 29) {
            self.s = @"29";
            self.test11(@"29");
            dispatch_semaphore_signal(self.sem);
        }
    }

}
-(void)test2{
    for (int i = 0; i < 300 ; i++) {
        if (i == 299) {
            self.s = @"299";
            self.test22(@"299");
             dispatch_semaphore_signal(self.sem);
        }
    }

}
-(void)test3{
    for (int i = 0; i < 1000000000; i++) {
        if (i == 99999999) {
            self.s = @"999";
            self.test33(@"999");
             dispatch_semaphore_signal(self.sem);
        }
    }
}
-(void)initSemRequest{
    //初始化
    self.sem = dispatch_semaphore_create(0);
    [self testGCDSemRequest];

    [self doAction:@"testA" andArgObject:nil];
    [self doAction:@"testB:" andArgObject:@"xixi"];
}

//创建信号量
//-(dispatch_semaphore_t)sem {
//    if (!_sem) {
//        _sem = dispatch_semaphore_create(0);
//    }
//    return _sem;
//}


-(void) doAction:(NSString *)methodsName andArgObject:(id)objectArg
{
    SEL selector = NSSelectorFromString(methodsName);
    if (self)
    {
        if ([self respondsToSelector:selector])
        {
            [self performSelectorOnMainThread:selector withObject:objectArg waitUntilDone:NO];
        }
    }
}

-(void) testA
{
    NSLog(@"do testA");
}

-(void) testB:(NSString *) str
{
    NSLog(@"do testB :%@",str);

}
@end
