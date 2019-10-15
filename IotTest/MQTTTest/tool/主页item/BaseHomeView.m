//
//  BaseHomeView.m
//  IotTest
//
//  Created by FCNC05 on 2019/8/26.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "BaseHomeView.h"

@implementation BaseHomeView

- (instancetype)initWithFrame:(CGRect)frame withFont:(CGFloat)font withTittleImageName:(NSString *)imageName withObject:(UIView *)ObjectView{
    if (self = [super initWithFrame:frame]) {

        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] init];
        effectview.frame = CGRectMake(0,0,100,100);
        effectview.contentView.backgroundColor = [UIColor whiteColor];
        effectview.contentView.alpha = 0.5f;
        [self addSubview:effectview];
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 15 ;
        self.layer.masksToBounds = YES;
        [self addSubview:self.tittleIconImageV];
        [self addSubview:self.contentLab];
        [self addSubview:self.tittleLab];
    }
    return self;
}
-(void)layoutSubviews {

    _tittleIconImageV.frame = CGRectMake(5, 5, 20, 20);
    _tittleIconImageV.backgroundColor = [UIColor redColor];

    _contentLab.frame = CGRectMake(CGRectGetWidth(self.frame)/2-50, CGRectGetMaxY(_tittleIconImageV.frame),100, 50);
    _contentLab.text = @"27.5°C";
    _contentLab.textColor = [UIColor whiteColor];
    _contentLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:23];//加粗
    _contentLab.textAlignment = NSTextAlignmentCenter;

    _tittleLab.text = @"厨房";
    _tittleLab.frame = CGRectMake(CGRectGetWidth(self.frame)/2-25, CGRectGetMaxY(_contentLab.frame),50, 30);
    _tittleLab.textColor = [UIColor whiteColor];
    _tittleLab.font = [UIFont systemFontOfSize:16];
    _tittleLab.textAlignment = NSTextAlignmentCenter;

}
-(UILabel *)tittleLab {
    if (!_tittleLab) {
        _tittleLab = [[UILabel alloc]init];
    }
    return _tittleLab;
}
-(UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
    }
    return _contentLab;
}
-(UIImageView *)tittleIconImageV {
    if (!_tittleIconImageV) {
        _tittleIconImageV = [[UIImageView alloc]init];
    }
    return _tittleIconImageV;
}
@end
