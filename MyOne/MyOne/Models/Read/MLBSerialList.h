//
//  MLBSerialList.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/27.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"
#import "MLBSearchRead.h"

@interface MLBSerialList : MLBBaseModel

@property (nonatomic, strong) NSString *serialId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *finished;
@property (nonatomic, strong) NSArray *list;

@end
