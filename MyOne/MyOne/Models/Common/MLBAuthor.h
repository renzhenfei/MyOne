//
//  MLBAuthor.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"

@interface MLBAuthor : MLBBaseModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, strong) NSString *wbName;
@property (nonatomic, strong) NSString *desc;

@end
