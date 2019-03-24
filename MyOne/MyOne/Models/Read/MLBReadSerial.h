//
//  MLBReadSerial.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"
@class MLBAuthor;
@interface MLBReadSerial : MLBBaseModel

@property (nonatomic, strong) NSString *contentId;
@property (nonatomic, strong) NSString *serialId;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *excerpt;
@property (nonatomic, strong) NSString *readNum;
@property (nonatomic, strong) NSString *makeTime;
@property (nonatomic, strong) MLBAuthor *author;
@property (nonatomic, assign) BOOL hasAudio;

@end
