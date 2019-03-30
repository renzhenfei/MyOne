//
//  MLBCommentList.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/30.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"
#import "MLBComment.h"

@interface MLBCommentList : MLBBaseModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray<MLBComment *> *hotComments; // 热门评论
@property (nonatomic, strong) NSMutableArray<MLBComment *> *comments; // 普通评论

@end
