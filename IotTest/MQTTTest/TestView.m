//
//  TestView.m
//  IotTest
//
//  Created by FCNC05 on 2019/7/5.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "TestView.h"
@implementation TestView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.nameLal];
        [self addSubview:self.adressLa];
    }
    return self;
}
-(void)layoutSubviews {
    self.nameLal.frame = CGRectMake(0, 0, 100, 40);
    self.nameLal.backgroundColor = [UIColor yellowColor];
    self.adressLa.frame = CGRectMake(0, 60, 100, 40);
}
-(UILabel *)nameLal {
    if (!_nameLal) {
        _nameLal  = [[UILabel alloc]init];
    }
    return _nameLal;
}
-(UILabel *)adressLa {
    if (!_adressLa) {
        _adressLa  = [[UILabel alloc]init];
    }
    return _adressLa;
}
-(viewShow)show {
    __weak typeof (self)weakSelf = self;
    return ^TestView *(NSString *lab){
        NSLog(@"show%@",lab);
        weakSelf.nameLal.text = lab;
//        [UIView animateWithDuration:1 animations:^{
//        weakSelf.nameLal.frame = CGRectMake(200, 24, 100, 40);
//        }];
        return weakSelf;
    };
}
-(viewShow)dismiss {
     __weak typeof (self)weakSelf = self;
    return ^TestView *(NSString *name){
        NSLog(@"dismiss%@",name);
        weakSelf.adressLa.text = name;
        return self;
    };
}
-(viewBackeColor)backColor {
    __weak typeof (self)weakSelf = self;
    return ^TestView *(UIColor *color){
        weakSelf.backgroundColor = color;
        return self;
    };
}
@end
