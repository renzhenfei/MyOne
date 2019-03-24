//
//  MLBReadCarouselItem.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseModel.h"

@interface MLBReadCarouselItem : MLBBaseModel

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *bottomText;
@property (nonatomic, strong) NSString *bgColor;
@property (nonatomic, strong) NSString *pvURL;

@end
