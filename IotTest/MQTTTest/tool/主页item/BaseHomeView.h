//
//  BaseHomeView.h
//  IotTest
//
//  Created by FCNC05 on 2019/8/26.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseHomeView : UIView
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIImageView *tittleIconImageV;
@property(nonatomic,strong)UILabel *tittleLab;

- (instancetype)initWithFrame:(CGRect)frame withFont:(CGFloat)font withTittleImageName:(NSString *)imageName withObject:(UIView *)ObjectView;
@end

NS_ASSUME_NONNULL_END
