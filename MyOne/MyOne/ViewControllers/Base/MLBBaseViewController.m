//
//  MLBBaseViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseViewController.h"
#import <YLImageView.h>
#import "MLBSearchViewController.h"
#import "MLBLiginOptsViewController.h"
@interface MLBBaseViewController ()<UIGestureRecognizerDelegate>

@property(strong,nonatomic)YLImageView *playerView;

@end

@implementation MLBBaseViewController

#pragma mark  - Lifecycle

- (void)dealloc
{
    DDLogDebug(@"%@ - %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置标题栏不能覆盖下面viewController的内容部分
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = self.hideNavigationBar;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.navigationController.viewControllers.count != 1;
}

#pragma mark  - Public Method
-(CGFloat)navigationBarHeight{
    return CGRectGetHeight(self.navigationController.navigationBar.bounds) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}

#pragma mark  -UI

-(void)addNavigationBarLeftBarItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(showSearchingViewController)];
}

-(void)addNavigationBarRightMeItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_me_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(pushMeViewController)];
}

#pragma mark - Action

-(void)showSearchingViewController{
    [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:[[MLBSearchViewController alloc] init]] animated:YES completion:nil];
}

-(void)pushMeViewController{
    [UIView beginAnimations:@"pushUserHome" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:[[MLBBaseViewController alloc] init] animated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[UIApplication sharedApplication].keyWindow cache:NO];
    [UIView commitAnimations];
}

#pragma mark - Action

-(void)presentLoginOptionsViewController{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MLBLiginOptsViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
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
