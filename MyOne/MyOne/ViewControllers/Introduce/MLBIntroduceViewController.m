//
//  MLBIntroduceViewController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBIntroduceViewController.h"
#import <YYImage/YYImage.h>
#import "AppDelegate.h"

@interface MLBIntroduceViewController () <UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) UIButton *entryButton;
@property(nonatomic,strong) YYAnimatedImageView *yyImageView0;
@property(nonatomic,strong) YYAnimatedImageView *yyImageView1;
@property(nonatomic,strong) YYAnimatedImageView *yyImageView2;
@property(nonatomic,strong) YYAnimatedImageView *yyImageView3;

@end

@implementation MLBIntroduceViewController{
    NSArray *gifNames;
    NSInteger currentIndex;
    NSInteger lastIndex;
    NSArray *yyImageViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDatas];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initDatas{
    gifNames = @[@"1.gif", @"2.gif", @"3.gif", @"4.gif"];
    currentIndex = 0;
    lastIndex = 0;
}

-(void)setupViews{
    self.scrollView = ({
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * gifNames.count, 0);
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        scrollView;
    });
    self.yyImageView0 = [YYAnimatedImageView new];
    self.yyImageView1 = [YYAnimatedImageView new];
    self.yyImageView2 = [YYAnimatedImageView new];
    self.yyImageView3 = [YYAnimatedImageView new];
    yyImageViews = @[self.yyImageView0,self.yyImageView1,self.yyImageView2,self.yyImageView3];
    for (int i = 0; i < gifNames.count; i++) {
        YYAnimatedImageView *imageView = yyImageViews[i];
        imageView.autoPlayAnimatedImage = NO;
        imageView.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl = ({
        UIPageControl *pageControl = [UIPageControl new];
        pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"6d7b90" andAlpha:0.78];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithRGBHex:0x6d7b90];
        pageControl.numberOfPages = gifNames.count;
        [pageControl addTarget:self action:@selector(pageControlDidChanged) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:pageControl];
        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-100);
        }];
        pageControl;
    });
    
    self.entryButton = ({
        UIButton *button = [UIButton new];
        [button setBackgroundImage:[UIImage imageNamed:@"skip"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(entry) forControlEvents:UIControlEventTouchUpInside];
        button.alpha = 0;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(136, 46));
            make.center.equalTo(self.pageControl);
        }];
        button;
    });
}

-(void)scrollViewCurrentPageDidChangedTo:(NSInteger)pageIndex{
    currentIndex = pageIndex;
    if (currentIndex == gifNames.count - 1) {
        self.pageControl.alpha = 0;
        self.entryButton.alpha = 1;
    } else {
        self.pageControl.alpha = 1;
        self.entryButton.alpha = 0;
    }
    
    [self playCurrentAnimation];
    lastIndex = currentIndex;
}

-(void)playCurrentAnimation{
    if (lastIndex != currentIndex) {
        YYAnimatedImageView *lastImageView = yyImageViews[lastIndex];
        if (lastImageView.currentIsPlayingAnimation) {
            [lastImageView stopAnimating];
            lastImageView.image = nil;
        }
    }
    YYAnimatedImageView *currentImageView = yyImageViews[currentIndex];
    if (!currentImageView.currentIsPlayingAnimation) {
        currentImageView.image = [YYImage imageNamed:gifNames[currentIndex]];
        [currentImageView startAnimating];
    }
}

#pragma mark - Action

-(void)pageControlDidChanged{
    [self.scrollView setContentOffset:CGPointMake(self.pageControl.currentPage * SCREEN_WIDTH, 0) animated:YES];
}

-(void)entry{
    NSString *version = [MLBUtilities appCurrentVersion];
    NSString *build = [MLBUtilities appCurrentBuild];
    NSString * versionAndBuild = [NSString stringWithFormat:@"%@_%@",version,build];
    [UserDefaults setObject:versionAndBuild forKey:MLBLastShowIntroduceVersionAndBuild];
    [(AppDelegate *)[UIApplication sharedApplication].delegate showMainTabBarontrollers];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint contentOffset = self.scrollView.contentOffset;
    int currentPage = contentOffset.x / SCREEN_WIDTH;
    BOOL hasGreatThanHalfScreen = contentOffset.x > (currentPage+ 0.5) * SCREEN_WIDTH;
    self.pageControl.currentPage = currentPage + (hasGreatThanHalfScreen ? 1 : 0);
    
    int leftLimit = (gifNames.count - 2 + 0.5) * SCREEN_WIDTH;
    int rightLimit = (gifNames.count - 1) * SCREEN_WIDTH;
    if (contentOffset.x >= leftLimit && contentOffset.x <= rightLimit) {
        CGFloat buttonAlpha = (contentOffset.x - leftLimit) / (SCREEN_WIDTH / 2);
        self.entryButton.alpha = buttonAlpha;
        self.pageControl.alpha = 1 - buttonAlpha;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewCurrentPageDidChangedTo:scrollView.contentOffset.x / SCREEN_WIDTH];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewCurrentPageDidChangedTo:scrollView.contentOffset.x / SCREEN_WIDTH];
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
