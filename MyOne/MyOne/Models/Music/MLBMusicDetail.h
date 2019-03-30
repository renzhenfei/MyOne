//
//  MLBMusicDetail.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/30.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"
#import "MLBAuthor.h"
@interface MLBMusicDetail : MLBBaseModel

@property (nonatomic, strong) NSString *musicId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *isFirst;
@property (nonatomic, strong) NSString *storyTitle;
@property (nonatomic, strong) NSString *story;
@property (nonatomic, strong) NSString *lyric;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSString *musicURL;
@property (nonatomic, strong) NSString *chargeEditor;
@property (nonatomic, strong) NSString *relatedTo;
@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, assign) NSInteger praiseNum;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *makeTime;
@property (nonatomic, strong) NSString *lastUpdateDate;
@property (nonatomic, strong) MLBAuthor *author;
@property (nonatomic, strong) MLBAuthor *storyAuthor;
@property (nonatomic, assign) NSInteger commentNum;
@property (nonatomic, strong) NSString *readNum;
@property (nonatomic, assign) NSInteger shareNum;

@property (nonatomic,assign) MLBMusicDetailsType contenttype;

@end
