//
//  MLBReadIndex.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"
#import "MLBReadEssay.h"
#import "MLBReadSerial.h"
#import "MLBReadQuestion.h"

@interface MLBReadIndex : MLBBaseModel

@property(nonatomic,strong) NSArray *essay;
@property(nonatomic,strong) NSArray *serial;
@property(nonatomic,strong) NSArray *question;

@end
