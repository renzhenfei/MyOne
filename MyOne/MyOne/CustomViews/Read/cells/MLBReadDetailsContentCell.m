//
//  MLBReadDetailsContentCell.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBReadDetailsContentCell.h"
#import "UIView+Frame.h"
NSString *const KMLReadDetailsContentCellID = @"KMLReadDetailsContentCellID";

@interface MLBReadDetailsContentCell()
@property(nonatomic,strong) UITextView *contentTextView;
@property(nonatomic,strong) MASConstraint *contentTextViewHeightConstraint;
@end

@implementation MLBReadDetailsContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    if (self.contentTextView) {
        return;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentTextView = ({
        UITextView *tv = [UITextView new];
        tv.backgroundColor = [UIColor whiteColor];
        tv.textColor = MLBLightBlackTextColor;
        tv.font = FontWithSize(16);
        tv.editable = NO;
        tv.scrollEnabled = NO;
        tv.showsVerticalScrollIndicator = NO;
        tv.showsHorizontalScrollIndicator = NO;
        tv.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8);
        [self.contentView addSubview:tv];
        [tv mas_makeConstraints:^(MASConstraintMaker *make) {
            self.contentTextViewHeightConstraint = make.height.mas_equalTo(0).priority(999);
            make.edges.equalTo(self.contentView);
        }];
        tv;
    });
}

- (void)configureCellWithContent:(NSString *)content editor:(NSString *)editor{
    if (IsStringEmpty(content)) {
        self.contentTextView.attributedText = nil;
        self.contentTextViewHeightConstraint.mas_equalTo(0);
        return;
    }
    self.contentTextView.with = self.with;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = MLBLineSpacing;
    
    NSDictionary *attribute = @{NSFontAttributeName:FontWithSize(16),
                                NSForegroundColorAttributeName:MLBLightBlackTextColor,
                                NSParagraphStyleAttributeName:paragraphStyle};
    NSString *editorText = [NSString stringWithFormat:@"<br>\n<br>%@<br>\n",editor];
    NSString *string = [NSString stringWithFormat:@"%@%@",content,editorText];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                                                                                                                                            NSCharacterEncodingDocumentAttribute:@(NSUnicodeStringEncoding)} documentAttributes:nil error:nil];
    NSRange editorRange = [attributeString.string rangeOfString:editor];
    [attributeString setAttributes:attribute range:NSMakeRange(0, attributeString.string.length - editorRange.length)];
    [attributeString setAttributes:@{ NSFontAttributeName : FontWithSize(12),
                                       NSForegroundColorAttributeName : MLBLightBlackTextColor,
                                       NSParagraphStyleAttributeName : paragraphStyle } range:editorRange];
    self.contentTextView.attributedText = attributeString;
    CGSize fitSize = [_contentTextView sizeThatFits:CGSizeMake(CGRectGetWidth(_contentTextView.bounds), CGFLOAT_MAX)];
    //    NSLog(@"fitSize = %@", NSStringFromCGSize(fitSize));
    self.contentTextViewHeightConstraint.equalTo(@(ceil(fitSize.height)));
}

@end












