//
//  AppDelegate.h
//  IotTest
//
//  Created by FCNC05 on 2019/6/24.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

