//
//  TransitionController.m
//  IotTest
//
//  Created by FCNC05 on 2019/10/8.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "TransitionController.h"

@interface TransitionController ()
@property(nonatomic,strong)HSPushAnimation *pushAnimation;
@end

@implementation TransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化
     self.pushAnimation = [[HSPushAnimation alloc] init];
}
-(void)viewWillAppear:(BOOL)animated{
      self.navigationController.delegate = self;
}
- (void)transitionDidSelecorAnimationType:(animationType)animationType withVC:(UIViewController *)transitionVC{
     self.pushAnimation = [[HSPushAnimation alloc] init];
     self.navigationController.delegate = self;
    self.pushAnimation.subtype = animationType;
    [self.navigationController pushViewController:transitionVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        if (self.pushAnimation.subtype != animationTypeNone) {
            return self.pushAnimation;
        }
    }
    return nil;
}

@end
