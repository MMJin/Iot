//
//  ViewController.m
//  IotTest
//
//  Created by FCNC05 on 2019/6/24.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "ViewController.h"
typedef enum:int
{
    ptlEnable = 0x01,
    ptlDisable = 0x00,

}PTLEnableDisable;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //获取对象的存储空间
    NSLog(@"===%ld\n",sizeof(PTLEnableDisable));
}

@end



