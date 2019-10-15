//
//  KVCStudyDictionary.h
//  IotTest
//
//  Created by FCNC05 on 2019/10/8.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVCStudyDictionary : NSObject

@property(nonatomic, strong)NSArray *list;
//存
- (void)setObject:(id)object forKey:(NSString*)key;
//取
- (id)objectForKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
