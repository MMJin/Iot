//
//  HSPushAnimation.m
//  HSPushPopTransitionDemo
//
//  Created by hejianyuan on 2017/5/4.
//  Copyright © 2017年 hejianyuan. All rights reserved.
//

#import "HSPushAnimation.h"

@implementation HSPushAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
  
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
   
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

//    if (self.subtype == animationTypeLeft || self.subtype == animationTypeRight) {
    [[transitionContext containerView] addSubview:toView];

    if (self.subtype == animationTypeLeft) {
        toView.frame = CGRectMake(-width, 0, width, height);
    } else if(self.subtype == animationTypeRight) {
        toView.frame = CGRectMake(width, 0, width, height);
    }
   //}
    //这里处理导航栏的问题
    UIView *barView = fromViewController.navigationController.navigationBar;
    UIImage *image = [self imageByCropping:barView toRect:barView.bounds];
    UIImageView *fromImageView = [[UIImageView alloc] initWithImage:image];
    [fromViewController.navigationController.navigationBar addSubview:fromImageView];
    UIImageView *toImageView = [[UIImageView alloc] initWithImage:image];
    [toViewController.navigationController.navigationBar addSubview:toImageView];
    
    /** containView */
//    UIView *containView = [transitionContext containerView];
//    [containView addSubview:toView];
    UIImageView *imageView = [toView subviews].firstObject;
    //视图的最后添加对象
    UIView *view = [toView subviews].lastObject;
    //view.frame = CGRectMake(0, height  - 64, width, 50);
    if (self.subtype == animationTypeSide) {
        [toView addSubview:imageView];
        toView.frame = CGRectMake(0, 64, 0, 0);
        imageView.frame = CGRectMake(0, 64, 0, 0);
        view.frame = CGRectMake(0, height  - 64, width, 50);
    }


    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    if (self.subtype == animationTypeLeft || self.subtype == animationTypeRight) {
        toView.frame = CGRectMake(0, 0, width, height);
        if (self.subtype == animationTypeLeft) {
            fromView.frame = CGRectMake(width, 0, width, height);
        }else if(self.subtype == animationTypeRight) {
            fromView.frame = CGRectMake(-width, 0, width, height);
        }
         }
        if (self.subtype == animationTypeSide) {
            toView.frame = CGRectMake(0, 64, width, height);
            imageView.frame = CGRectMake(0, 64, width, 220);
            //这里将视图的最后一个空间变形
            view.frame = CGRectMake(0, height - 50 - 64, width, 50);
        }
        // ios 转场动画。导航栏 titleview 位Ø置跳动
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        // 动画结束，清空自定义转场动画
        self.subtype = animationTypeNone;
        // 利用截图覆盖titleview 跳动动画
        [fromImageView removeFromSuperview];
        [toImageView removeFromSuperview];
        
        // 获取当前路由的控制器数组
        NSMutableArray *vcArray = [NSMutableArray arrayWithArray:toViewController.navigationController.viewControllers];
    
        // 获取档期控制器在路由的位置
        int index = (int)[vcArray indexOfObject:fromViewController];
        // 移除当前路由器
        [vcArray removeObjectAtIndex:index];
        
        // 重新设置当前导航控制器的路由数组
        [toViewController.navigationController setViewControllers:vcArray animated:NO];
    }];
}

-(UIImage*)imageByCropping:(UIView*)imageToCrop toRect:(CGRect)rect
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize pageSize = CGSizeMake(scale*rect.size.width, scale*rect.size.height) ;
    UIGraphicsBeginImageContext(pageSize);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
    
    CGContextRef resizedContext =UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext,-1*rect.origin.x,-1*rect.origin.y);
    [imageToCrop.layer renderInContext:resizedContext];
    UIImage*imageOriginBackground =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageOriginBackground = [UIImage imageWithCGImage:imageOriginBackground.CGImage scale:scale orientation:UIImageOrientationUp];
    
    return imageOriginBackground;
}
@end
