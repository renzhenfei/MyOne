//
//  MLBHomeView.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/15.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

NSString *const KMLHomeViewId = @"KMLHomeViewId";

#import "MLBHomeView.h"
#import "MLBUIFactory.h"
#import "UIView+MyOne.h"
#import "MLBBaseViewController.h"
#import "MLBHomeItem.h"
@interface MLBHomeView()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *diaryButton;
@property (nonatomic,strong) UIButton *likeButton;
@property (nonatomic,strong) UILabel *likeNumLabel;
@property (nonatomic,strong) UIButton *moreButton;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImageView *coverView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *weatherView;
@property (strong, nonatomic) UILabel *temperatureLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UITextView *contentTextView;
@property (strong, nonatomic) UILabel *volLabel;

@property (strong, nonatomic) MASConstraint *textViewHeightConstraint;

@end

@implementation MLBHomeView

#pragma mark LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark Public Method

-(void)configireViewWithHomeItem:(MLBHomeItem *)homeItem atIndex:(NSInteger)index{
    [self configureViewWithHomeItem:homeItem atIndex:index inViewController:nil];
}

-(void)configureViewWithHomeItem:(MLBHomeItem *)homeItem atIndex:(NSInteger)index inViewController:(MLBBaseViewController *)viewController{
    self.viewIndex = index;
    self.parentViewController = viewController;
    [self.coverView mlb_sd_setImageWithURL:homeItem.imageURL placeholderImageName:@"home_cover_placeholder" cachePlaceholderImage:NO];
    self.titleLabel.text = homeItem.authorName;
    self.weatherView.image = [UIImage imageNamed:@"light_rain"];
    self.temperatureLabel.text = @"6℃";
    self.locationLabel.text = @"杭州";
    self.dateLabel.text = [MLBUtilities stringDateFormatWithEEEddMMyyyyByNormalDateString:homeItem.makeTime];
    self.contentTextView.attributedText = [MLBUtilities mlb_attributedStringWithText:homeItem.content lineSpacing:MLBLineSpacing font:self.contentTextView.font textColor:self.contentTextView.textColor];
    self.textViewHeightConstraint.equalTo(@(ceilf([MLBUtilities mlb_rectWithAttributedString:self.contentTextView.attributedText size:CGSizeMake(SCREEN_WIDTH - 24 - 12, CGFLOAT_MAX)].size.height + 50)));
    self.volLabel.text = homeItem.title;
    self.scrollView.contentOffset = CGPointZero;
    // 如果是-1，说明是单个视图界面，则显示按钮上的图片和点赞数
    if (index == -1) {
        [self.diaryButton setImage:[UIImage imageNamed:@"diary_normal"] forState:UIControlStateNormal];
        [self.moreButton setImage:[UIImage imageNamed:@"share_image"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"like_normal"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateSelected];
        self.likeNumLabel.text =[@(homeItem.praiseNum) stringValue];
    }
    self.diaryButton.hidden = index != -1;
    self.moreButton.hidden = index != -1;
    self.likeButton.hidden = index != -1;
    self.likeNumLabel.hidden = index != -1;
}
#pragma mark Private Method

-(void)setupViews{
    if (self.scrollView) {
        return;
    }
//    self.backgroundColor = [UIColor clearColor];
    self.scrollView = ({
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        scrollView;
    });
    
    self.diaryButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:nil highLightImageName:nil target:self action:@selector(diaryButtonClicked)];
        [self.scrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(66, 44));
            make.left.equalTo(self.scrollView).offset(8);
            make.bottom.equalTo(self).offset(-73);
        }];
        button;
    });
    
    self.moreButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:nil highLightImageName:nil target:self action:@selector(moreButtonClicked)];
        [self.scrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.right.equalTo(self.scrollView).offset(-8);
            make.bottom.equalTo(self.diaryButton);
        }];
        button;
    });
    
    self.likeNumLabel = ({
        UILabel *lable = [UILabel new];
        lable.textColor = MLBDarkGrayTextColor;
        lable.font = FontWithSize(11);
        [self.scrollView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.right.equalTo(self.moreButton.mas_left);
            make.bottom.equalTo(self.diaryButton);
        }];
        lable;
    });
    
    self.likeButton = ({
        UIButton *likeButton = [MLBUIFactory buttonWithImageName:nil highLightImageName:nil target:self action:@selector(likeButtonClicked)];
        [self.scrollView addSubview:likeButton];
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.right.equalTo(self.likeNumLabel.mas_left);
            make.bottom.equalTo(self.diaryButton);
        }];
        likeButton;
    });
    
    _contentView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.shadowColor = MLBShadowColor.CGColor;// #666666
        view.layer.shadowRadius = 2;
        view.layer.shadowOffset = CGSizeZero;
        view.layer.shadowOpacity = 0.5;
        view.layer.cornerRadius = 5;
        [_scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView).insets(UIEdgeInsetsMake(76, 12, 184, 12));
            make.width.equalTo(@(SCREEN_WIDTH - 24));
        }];
        
        view;
    });
    
    _coverView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverTapped)];
        [imageView addGestureRecognizer:tap];
        [_contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(_contentView).insets(UIEdgeInsetsMake(6, 6, 0, 6));
            make.height.equalTo(imageView.mas_width).multipliedBy(0.75);
        }];
        
        imageView;
    });
    
    _volLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBLightGrayTextColor;
        label.font = FontWithSize(11);
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_coverView.mas_bottom).offset(10);
            make.left.equalTo(_coverView);
        }];
        
        label;
    });
    
    _titleLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBGrayTextColor;
        label.font = FontWithSize(10);
        label.textAlignment = NSTextAlignmentRight;
        [label setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_coverView.mas_bottom).offset(8);
            make.left.greaterThanOrEqualTo(_volLabel.mas_right).offset(4);
            make.right.equalTo(_coverView);
        }];
        
        label;
    });
    
    _contentTextView = ({
        UITextView *textView = [UITextView new];
        textView.backgroundColor = [UIColor whiteColor];
        textView.textColor = MLBLightBlackTextColor;
        textView.font = FontWithSize(14);
        textView.editable = NO;
        [_contentView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_volLabel.mas_bottom).offset(15);
            make.left.right.equalTo(_coverView);
            _textViewHeightConstraint = make.height.equalTo(@0);
        }];
        
        textView;
    });
    
    _dateLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBDarkGrayTextColor;
        label.font = FontWithSize(12);
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentTextView.mas_bottom).offset(10);
            make.right.equalTo(_coverView);
            make.bottom.equalTo(_contentView).offset(-12);
        }];
        
        label;
    });
    
    _locationLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBDarkGrayTextColor;
        label.font = FontWithSize(12);
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_dateLabel);
            make.right.equalTo(_dateLabel.mas_left).offset(-10);
        }];
        
        label;
    });
    
    _temperatureLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBDarkGrayTextColor;
        label.font = FontWithSize(12);
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_dateLabel);
            make.right.equalTo(_locationLabel.mas_left).offset(-2);
        }];
        
        label;
    });
    
    _weatherView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@24);
            make.centerY.equalTo(_dateLabel);
            make.right.equalTo(_temperatureLabel.mas_left).offset(-5);
        }];
        
        imageView;
    });
}

#pragma mark Action

-(void)diaryButtonClicked{
    if (self.clickButton) {
        self.clickButton(MLBActionTypeDiary);
    }
}

-(void)moreButtonClicked{
    if (self.clickButton) {
        self.clickButton(MLBActionTypeMore);
    }else if(self.parentViewController){
        [self.parentViewController.view mlb_showPopMenuViewWithMenuSelectedBlock:^(MLBPopMenuType menuType) {
            DDLogDebug(@"menuType = %ld",menuType);
        }];
    }
}

-(void)likeButtonClicked{
    
}

-(void)coverTapped{
    [self blowUpImage:self.coverView.image referenceRect:self.coverView.frame referenceView:self.coverView.superview];
}

@end














