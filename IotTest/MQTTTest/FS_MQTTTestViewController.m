//
//  FS_MQTTTestViewController.m
//  IotTest
//
//  Created by FCNC05 on 2019/6/24.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "FS_MQTTTestViewController.h"
#import "TranDemoViewController.h"
#import <ReactiveObjC.h>

#import "GCDSemaphore.h"
#import "BaseGCDSemaphore.h"
#import "ObjcSystemCallTool.h"
#import "BaseHomeView.h"

#import "DropdownSelector.h"

#import "ContentView.h"
//第一次修改提交
#ifdef EZDISABLE
#import "TestView.h"
#endif
//  自适应宽度和高度
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

// 判断是否是iPhone X
#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (IS_IPHONEX ? 44.f : 20.f)
// 导航栏高度
#define KNAVIVIEWHEIGHT (IS_IPHONEX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (IS_IPHONEX ? (49.f + 34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (IS_IPHONEX ? 34.f : 0.f)
@interface FS_MQTTTestViewController ()<UIScrollViewDelegate,ContentViewDelegate>
@property(nonatomic,strong)UIButton *testBtn;
@property(nonatomic,strong)UITextField *testField;
@property(nonatomic,strong)RACSignal *subSignal;
@property(nonatomic,strong)RACDisposable *disposable;
#ifdef EZDISABLE
@property(nonatomic,strong)TestView *tsView;
#endif

@property(nonatomic,strong)BaseGCDSemaphore *sem;
@property (nonatomic, assign) CGFloat      startOffsetX;
@property (nonatomic ,strong) ContentView  *pageView;
@property (nonatomic ,strong) UIScrollView *contentScrollView;
@end

@implementation FS_MQTTTestViewController
-(void)createS{
    self.startOffsetX = 0;

    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KNAVIVIEWHEIGHT)];
    [navBar setBackgroundColor:[UIColor colorWithRed:248.f/255.f green:248.f/255.f blue:248.f/255.f alpha:1.f]];
    [self.view addSubview:navBar];

    self.pageView = [[ContentView alloc] initWithFrame:CGRectMake(20.f, 400, SCREEN_WIDTH-40.f, 44.f) titlesArray:@[@"新风总控",@"地暖总控",@"主卧",@"副卧",@"厨房",]];
    self.pageView.backgroundColor = [UIColor greenColor];
   // self.pageView.imagesArray = @[@"NewestSelected",@"Hottest",@"Hottest"];
    self.pageView.titleFont = [UIFont systemFontOfSize:17.0];
    //    self.pageView.scrollViewBackgroundColor = [UIColor orangeColor];
    self.pageView.delegate = self;
    self.pageView.imageLeft = 10.0;
    self.pageView.labelRight = 10.0;
    self.pageView.space = 10.0;
    self.pageView.headerImageName = @"header.png";
    [self.pageView initalUI];
    [self.view addSubview:self.pageView];

    self.contentScrollView = ({
//SCREEN_HEIGHT - KNAVIVIEWHEIGHT - TAB_BAR_HEIGHT
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.pageView.frame), SCREEN_WIDTH , 200)];
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5.f, 0.f);
        scrollView.backgroundColor = [UIColor colorWithRed:248.f/255.f green:248.f/255.f blue:248.f/255.f alpha:1.f];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        [self.view addSubview:scrollView];
        scrollView;

    });

    for (NSInteger i = 0; i < 5; i++)
    {
        NSInteger R = (arc4random() % 256);
        NSInteger G = (arc4random() % 256);
        NSInteger B = (arc4random() % 256);

        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0.f, SCREEN_WIDTH, CGRectGetHeight(self.contentScrollView.frame))];
        colorView.backgroundColor = [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:1.f];
        [self.contentScrollView addSubview:colorView];
    }
}
#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging || scrollView.isDecelerating)
    {
        [self.pageView externalScrollView:scrollView totalPage:5 startOffsetX:self.startOffsetX];
    }
}

#pragma mark -
#pragma mark GLYPageViewDelegate
- (void)pageViewSelectdIndex:(NSInteger)index
{
    //点击的话不做动画 //隔壁的话动画可以记录上次的点击索引
    [self.contentScrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createS];
    [self setUI];
    [self createSignal];
    [self methodResponse];
    #ifdef EZDISABLE
    _tsView = [TestView new];
    _tsView.frame = CGRectMake(0, 64, 200, 100);
    [self.view addSubview:_tsView.show(@"展示").dismiss(@"消失")];
    #endif

    [self timer];
    self.sem = [[BaseGCDSemaphore alloc]initWithSelectorNmaeArr:@[@"createSignal",@"createMoreHttpRequest"] withObject:self withResult:^(NSString * _Nonnull result) {
        if ([result isEqualToString:@"1"]) {
        NSLog(@"所有数据请求完成可以刷新主界面了");
        }
        else {
            //超时处理
        }
    }];
    BaseHomeView *baseV = [[BaseHomeView alloc]initWithFrame:CGRectMake(200, 200, 100, 100) withFont:12 withTittleImageName:@"" withObject:self.view];
    [self.view addSubview:baseV];
    // self.view.backgroundColor = [UIColor greenColor];
    DropdownSelector *drop = [[DropdownSelector alloc]initWithFrame:CGRectMake(200, 310, 100, 80) withSetResultBlock:^(NSString * _Nonnull result) {
        NSLog(@"选择结果%@",result);
        TranDemoViewController *VC = [TranDemoViewController new];
        //[self transitionDidSelecorAnimationType:animationTypeSide withVC:VC];
        [self.navigationController pushViewController:VC animated:YES];
    }];
    [self.view addSubview:drop];
}
-(void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _testBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    _testBtn.frame = CGRectMake(100, 100, 100, 100);
    _testBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_testBtn];

    _testField = [[UITextField alloc]init];
    _testField.backgroundColor = [UIColor grayColor];
    _testField.frame = CGRectMake(0,CGRectGetMaxY(_testBtn.frame), 100, 40);
    [self.view addSubview:_testField];
}
-(void)methodResponse {
    //监听按钮点击事件
    __weak typeof(self)weakSelf = self;
    [[_testBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"-->%@",x);
//        weakSelf.tsView.backColor([UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:0.8]);
        //weakSelf.view.backgroundColor = [UIColor greenColor];
       // [weakSelf anmationForView:weakSelf.testBtn];
       // [weakSelf.subSignal  subscribeNext:^(id  _Nullable x) {
       // }];

        //线程处理 同步信号量 线程锁 测试
//        NSCondition *cod = [[NSCondition alloc]init];
//        [cod lock];
//        //确保这边的变量处理时 如果没有执行完成，其他地方无法更改数据
//        //[weakSelf createMoreHttpRequest];
//        [cod unlock];

        //调用系统设置方法
        [ObjcSystemCallTool callSystemSet];

    }];
    //监听文本输入 添加判断条件
    [[_testField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return [value isEqualToString:@"T"];
    }]subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输入框内容：%@", x);
        [weakSelf.subSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"输入框内容2：%@", x);
        }];
    }];
//    [[_testField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"监听文本%@",x);
//    }];
}
-(void)timer{
    @weakify(self)
    self.disposable = [[RACSignal interval:2 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self)
        NSLog(@"时间：%@", x); // x 是当前的时间
        //关闭计时器
        [self.disposable dispose];
    }];
}
-(void)anmationForView:(UIView *)temView{//缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.5;
    [temView.layer addAnimation:scaleAnimation forKey:@"Animation"];
}
-(void)createSignal {
    __weak typeof(self)weakSelf = self;
   _subSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {//里面处理一下请求结果 再作转发
        [subscriber sendNext:@[@"显示屏",@"Pair机",@"香氛组件"]];
        [subscriber sendCompleted];
        [weakSelf.sem semFinish];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal1销毁了");
        }];
    }];
}
//多个请求结果同时满足时执行刷新或者其他操作方法
-(void)createMoreHttpRequest {
    RACSignal *signal1 =[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        for (int i = 1; i<1000; i++) {
            NSLog(@"");
        }
        [subscriber sendNext:@"1完成"];
        [subscriber sendCompleted];
       return [RACDisposable disposableWithBlock:^{
            NSLog(@"请求数据1完成");
        }];
    }];

    RACSignal *signal2 =[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        for (int i = 1; i<100; i++) {
            NSLog(@"");
        }
        [subscriber sendNext:@"2完成"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"请求数据2完成");
        }];
    }];

    RACSignal *signal3 =[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        for (int i = 1; i<10000; i++) {
            NSLog(@"");
        }
        //while ([self.testField.text isEqualToString:@"T"]) {
           [subscriber sendNext:@"3完成"];
        //}
        [subscriber sendCompleted]; //完成先执行
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"请求数据3完成");
        }];
    }];

    [self rac_liftSelector:@selector(requestWithResult1:Result2:Result3:) withSignals:signal1,signal2,signal3, nil];
}
-(void)requestWithResult1:(NSString *)result1 Result2:(NSString *)result2 Result3:(NSString *)result3{
    if (result1.length == result2.length ==result3.length) {
        NSLog(@"请求数据全部完成");
        [self.sem semFinish];
    }
    else {
        NSLog(@"请求数据全部失败");
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}
@end
