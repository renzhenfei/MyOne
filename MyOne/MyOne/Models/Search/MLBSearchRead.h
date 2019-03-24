//
//  MLBSearchRead.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/28.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"

@interface MLBSearchRead : MLBBaseModel

@property (nonatomic, strong) NSString *readId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger number;

@end
