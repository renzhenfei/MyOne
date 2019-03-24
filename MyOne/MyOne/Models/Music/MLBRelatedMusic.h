//
//  MLBRelatedMusic.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"
#import "MLBAuthor.h"
@interface MLBRelatedMusic : MLBBaseModel

@property (nonatomic, strong) NSString *musicId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSString *musicLongId;
@property (nonatomic, strong) MLBAuthor *author;

@end
