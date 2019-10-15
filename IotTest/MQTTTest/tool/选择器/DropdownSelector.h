//
//  DropdownSelector.h
//  IotTest
//
//  Created by FCNC05 on 2019/8/28.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ResultBlock)(NSString * _Nonnull result);
NS_ASSUME_NONNULL_BEGIN

@interface DropdownSelector : UIView

-(instancetype)initWithFrame:(CGRect)frame withSetResultBlock:(ResultBlock)result;
@end

NS_ASSUME_NONNULL_END
