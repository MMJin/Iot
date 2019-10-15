//
//  DropdownSelector.m
//  IotTest
//
//  Created by FCNC05 on 2019/8/28.
//  Copyright © 2019 FCNC05. All rights reserved.
//
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import "DropdownSelector.h"
@interface DropdownSelector()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)CGRect tempFrame;
@property(nonatomic,strong)UIImageView *arrowImg;
@property(nonatomic,strong)UILabel *familyLab;
@property(nonatomic,strong)UIButton *shadowBtn;
@property(nonatomic,strong)UITableView *familySetList;
@property(nonatomic,copy)ResultBlock result;
@end
@implementation DropdownSelector

-(instancetype)initWithFrame:(CGRect)frame withSetResultBlock:(ResultBlock)result{
    if (self = [super initWithFrame:frame]) {
    [self addSubview:self.arrowImg];
    [self addSubview:self.familyLab];
    [self addSubview:self.shadowBtn];
    [self addSubview:self.familySetList];
    self.result = result;
    [self UISet];
    }
    return self;
}
//显示区域 图片旋转 表动画 表选择结果需要发返回更新显示
-(void)layoutSubviews {
}
-(void)UISet {
    
    //图片
    self.arrowImg.frame = CGRectMake(0, 0, 20, 20);
    self.arrowImg.backgroundColor = [UIColor redColor];
    //家庭名称
    self.familyLab.frame = CGRectMake(20, 0, 80, 20);
    self.familyLab.text = @"XX家";
    //透明按钮遮罩
    self.shadowBtn.frame = CGRectMake(0, 0, 100, 20);
    self.shadowBtn.backgroundColor = [UIColor clearColor];
    [self.shadowBtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    //表显示
    self.familySetList.delegate = self;
    self.familySetList.dataSource = self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //设置列表中的每一项文本、字体、颜色等
    cell.textLabel.text = @"家庭设置";
    cell.textLabel.textColor = RGBA(136, 136, 136, 1.0);
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = RGBA(228, 228, 228, 1.0);
    return cell;
}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.familyLab.text = @"家庭设置";
    self.result(self.familyLab.text);
    [self hidden];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
-(void)show{
    CGRect frame = self.familySetList.frame;
    frame.size.height = 60;
    [UIView animateWithDuration:0.2 animations:^{
        self.familySetList.frame = frame;
        self.arrowImg.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {

    }];
    [self.familySetList reloadData];
}
-(void)hidden{
    CGRect frame = self.familySetList.frame;
    frame.size.height = 00;
    [UIView animateWithDuration:0.2 animations:^{
    self.familySetList.frame = frame;
    self.arrowImg.transform =  CGAffineTransformMakeRotation(2*M_PI);
    } completion:^(BOOL finished) {
    }];
}
-(void)transfrom {
//图片方向改变
//    UIImage *backImage = [UIImage imageNamed:;
//    //改变该图片的方向
//    backImage = [UIImage imageWithCGImage:backImage.CGImage
//                                    scale:backImage.scale
//                              orientation:UIImageOrientationDown];
}
-(UIImageView *)arrowImg{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc]init];
    }
    return _arrowImg;
}
-(UILabel *)familyLab{
    if (!_familyLab) {
        _familyLab = [[UILabel alloc]init];
    }
    return _familyLab;
}
-(UIButton *)shadowBtn{
    if (!_shadowBtn) {
        _shadowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _shadowBtn;
}
-(UITableView *)familySetList{
    if (!_familySetList) {
        _familySetList = [[UITableView alloc]initWithFrame:CGRectMake(0,20, 100, 0) style:UITableViewStylePlain];
    }
    return _familySetList;
}
@end
