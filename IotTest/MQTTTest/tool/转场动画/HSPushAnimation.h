//
//  HSPushAnimation.h
//  HSPushPopTransitionDemo
//
//  Created by hejianyuan on 2017/5/4.
//  Copyright © 2017年 hejianyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, animationType) {
    animationTypeNone                       = 0,
    animationTypeLeft                       = 1,
    animationTypeRight                      = 2,
    animationTypeSide                       = 3
};
@interface HSPushAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) animationType subtype;
@end
