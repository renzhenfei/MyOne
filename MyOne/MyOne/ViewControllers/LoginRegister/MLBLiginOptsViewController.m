//
//  MLBLiginOptsViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBLiginOptsViewController.h"
#import "MLBUIFactory.h"

@interface MLBLiginOptsViewController ()

@property(strong,nonatomic) UIImageView *bgImageView;
@property(strong,nonatomic) UIVisualEffectView *effectView;
@property(strong,nonatomic) UIButton *closeButton;
@property(strong,nonatomic) UIButton *wechatLoginButton;
@property(strong,nonatomic) UIButton *weiboLoginButton;
@property(strong,nonatomic) UIButton *qqLoginButton;
@property(strong,nonatomic) UIButton *mobileLoginButton;
@property(strong,nonatomic) UIButton *provisionButton;

@end

@implementation MLBLiginOptsViewController

#pragma mark - Lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.hideNavigationBar = YES;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self initDatas];
    [self setupViews];
}

#pragma mark - Private Method

-(void)initDatas{
    
}

-(void)setupViews{
    self.bgImageView = ({
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalBackgroundImage"]];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        bgImageView;
    });
    
    self.effectView = ({
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        effectView.alpha = 0.7f;
        [self.view addSubview:effectView];
        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        effectView;
    });
    
    self.closeButton = ({
        UIButton *closeButton = [MLBUIFactory buttonWithImageName:@"close_normal_white" highLightImageName:@"close_highlighted" target:self action:@selector(close)];
        [self.effectView.contentView addSubview:closeButton];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.left.equalTo(self.effectView.contentView);
            make.top.equalTo(self.effectView.contentView).offset(22);
        }];
        closeButton;
    });
    
    UILabel *titleLable = ({
        UILabel *lable = [UILabel new];
        lable.text = @"登录ONE";
        lable.textColor = [UIColor whiteColor];
        lable.font = FontWithSize(15);
        [self.effectView.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.effectView.contentView);
            make.centerY.equalTo(self.closeButton);
        }];
        lable;
    });
    
    UIView *optsView = ({
        UIView *view = [UIView new];
        [self.effectView.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLable.mas_bottom).offset(72);
            make.left.equalTo(self.effectView.contentView).offset(25);
            make.right.equalTo(self.effectView.contentView).offset(-25);
        }];
        view;
    });
    _wechatLoginButton = ({
        UIButton *button = [MLBUIFactory buttonWithBackgroundImageName:@"wechatLogin" highLightImageName:@"wechatLoginHigh" target:self action:@selector(wechatLogin)];
        [optsView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@40);
            make.left.top.right.equalTo(optsView);
        }];
        
        button;
    });
    
    _weiboLoginButton = ({
        UIButton *button = [MLBUIFactory buttonWithBackgroundImageName:@"weiboLogin" highLightImageName:@"weiboLoginHigh" target:self action:@selector(weiboLogin)];
        [optsView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@40);
            make.top.equalTo(_wechatLoginButton.mas_bottom).offset(10);
            make.left.right.equalTo(optsView);
        }];
        
        button;
    });
    
    _qqLoginButton = ({
        UIButton *button = [MLBUIFactory buttonWithBackgroundImageName:@"qqLogin" highLightImageName:@"qqLoginHigh" target:self action:@selector(qqLogin)];
        [optsView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@40);
            make.top.equalTo(_weiboLoginButton.mas_bottom).offset(10);
            make.left.right.equalTo(optsView);
        }];
        
        button;
    });
    
    UILabel *orLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"或者";
        label.textColor = [UIColor whiteColor];
        label.font = FontWithSize(12);
        [optsView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(optsView);
            make.top.equalTo(_qqLoginButton.mas_bottom).offset(10);
        }];
        
        label;
    });
    
    _mobileLoginButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:@"mobileLogin" highLightImageName:@"mobileLogin" target:self action:@selector(mobileLogin)];
        [optsView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orLabel.mas_bottom).offset(10);
            make.centerX.equalTo(optsView);
            make.bottom.equalTo(optsView);
        }];
        
        button;
    });
    
    _provisionButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(lookupProvision) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.textColor = [UIColor whiteColor];
        button.titleLabel.font = FontWithSize(10);
        button.titleLabel.numberOfLines = 0;
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"创建账号即代表您同意\n使用条款和隐私条约" attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
        [button setAttributedTitle:attributedString forState:UIControlStateNormal];
        [_effectView.contentView addSubview:button];
        NSInteger sideMargin = ceil((SCREEN_WIDTH - 10 * 2) / 3.0) + 10;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_effectView.contentView).insets(UIEdgeInsetsMake(0, sideMargin, 10, sideMargin));
        }];
        
        button;
    });
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)mobileLogin{
    
}

-(void)wechatLogin{
    
}

-(void)weiboLogin{
    
}

-(void)qqLogin{
    
}

-(void)lookupProvision{
//    self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
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
