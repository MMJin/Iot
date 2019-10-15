//
//  TestView.h
//  IotTest
//
//  Created by FCNC05 on 2019/7/5.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestView;
typedef TestView *_Nullable(^viewShow)(NSString * _Nullable name);//可以为空_Nullable
typedef TestView *_Nonnull(^viewDismiss)(NSString * _Nonnull name);//不可以为空
typedef TestView *_Nullable(^viewBackeColor)(UIColor * _Nullable bColor);
NS_ASSUME_NONNULL_BEGIN

@interface TestView : UIView
@property(nonatomic,copy)viewShow show;
@property(nonatomic,copy)viewDismiss dismiss;
@property(nonatomic,strong)UILabel *nameLal;
@property(nonatomic,strong)UILabel *adressLa;
-(viewShow)show;
-(viewBackeColor)backColor;
@end

NS_ASSUME_NONNULL_END
