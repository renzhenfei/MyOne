//
//  MLBCommentCell.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseCell.h"

typedef NS_ENUM(NSUInteger, MLBCommentCellButtonType) {
    MLBCommentCellButtonTypeUserAvatar, // 点击头像
    MLBCommentCellButtonTypePraise,        // 点赞
    MLBCommentCellButtonTypeUnfold,        // 展开
};

FOUNDATION_EXPORT NSString *const KMLCommentCellID;

@class MLBMovieStory;
@class MLBMovieReview;
@class MLBComment;

@interface MLBCommentCell : MLBBaseCell

@property (nonatomic, assign, getter=isLastHotComment) BOOL lastHotComment;

@property (nonatomic, copy) void (^cellButtonClicked)(MLBCommentCellButtonType type, NSIndexPath *indexPath);

- (void)configureCellForMovieWithStory:(MLBMovieStory *)story atIndexPath:(NSIndexPath *)indexPath;

- (void)configureCellForMovieWithReview:(MLBMovieReview *)review atIndexPath:(NSIndexPath *)indexPath;

- (void)configureCellForCommonWithComment:(MLBComment *)comment atIndexPath:(NSIndexPath *)indexPath;

@end
