//
//  TransitionController.h
//  IotTest
//
//  Created by FCNC05 on 2019/10/8.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSPushAnimation.h"
NS_ASSUME_NONNULL_BEGIN

@interface TransitionController : UIViewController<UINavigationControllerDelegate>
- (void)transitionDidSelecorAnimationType:(animationType)animationType withVC:(UIViewController *)transitionVC;
@end

NS_ASSUME_NONNULL_END
