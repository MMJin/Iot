//
//  TranDemo2ViewController.m
//  IotTest
//
//  Created by FCNC05 on 2019/10/8.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "TranDemo2ViewController.h"
#import "TranDemoViewController.h"
@interface TranDemo2ViewController ()
@property(nonatomic,strong)UIButton *testBtn;
@end

@implementation TranDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
       _testBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
       _testBtn.frame = CGRectMake(100, 100, 100, 100);
       _testBtn.backgroundColor = [UIColor greenColor];
       [_testBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:_testBtn];


}
-(void)test{
    TranDemoViewController *VC = [TranDemoViewController new];
    [self transitionDidSelecorAnimationType:animationTypeSide withVC:VC];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
