//
//  KVCStudyDictionary.m
//  IotTest
//
//  Created by FCNC05 on 2019/10/8.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "KVCStudyDictionary.h"
#import <objc/runtime.h>

@interface KVCStudyDictionary()
///声明一个存储用的字典storeDic，用于存储属性值
@property(nonatomic, strong)NSMutableDictionary *storeDic;
@end
@implementation KVCStudyDictionary
///用@dynamic修饰属性，代表不自动生成setter和getter
@dynamic list;


///初始化和动态方法解析
- (instancetype)init {
    self = [super init];
    if (self) {
          ///初始化存储用的字典
        _storeDic = [NSMutableDictionary dictionary];
    }
    return self;
}
///本例的关键，在这里进行动态方法解析，并插入新的方法实现
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selString = NSStringFromSelector(sel);
    if ([selString hasPrefix:@"set"]) {
        class_addMethod(self,sel,(IMP)dicSetter,"v@:@");
    }else {
        class_addMethod(self, sel, (IMP)dicGetter, "@@:");
    }
    return YES;
}
///getter
id dicGetter(id self, SEL sel) {
    KVCStudyDictionary *kvcDic = (KVCStudyDictionary*)self;
    NSString *key = NSStringFromSelector(sel);
    return [kvcDic.storeDic objectForKey:key];
}

///setter
void dicSetter(id self, SEL sel,id value) {
    KVCStudyDictionary *kvcDic = (KVCStudyDictionary*)self;
    NSString *selString = NSStringFromSelector(sel);

    NSMutableString *key = [selString mutableCopy];

    //去除尾部":"
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];

    //去除"set"
    [key deleteCharactersInRange:NSMakeRange(0, 3)];

    //更改驼峰大小写
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:[[key substringToIndex:1] lowercaseString]];

    if (value) {
        [kvcDic.storeDic setObject:value forKey:key];
    }else {
        [kvcDic.storeDic removeObjectForKey:key];
    }
}
///详细的异常处理我就省略了。。。
- (void)setObject:(id)object forKey:(NSString*)key {
    if (object && key && key.length >0) {
        [self.storeDic setObject:object forKey:key];
    }else {
        [self.storeDic removeObjectForKey:key];
    }
}

- (id)objectForKey:(NSString*)key {
    if (key && key.length > 0) {
        return [self.storeDic objectForKey:key];
    }else {
        return nil;
    }
}

@end
