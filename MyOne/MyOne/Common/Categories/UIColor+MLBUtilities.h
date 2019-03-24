//
//  UIColor+MLBUtilities.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/12.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MLBUtilities)

@property(nonatomic,readonly) CGColorSpaceModel colorSpaceModel;
@property(nonatomic,readonly) BOOL canProvideRGBComponents;
@property(nonatomic,readonly) CGFloat red;
@property(nonatomic,readonly) CGFloat green;
@property(nonatomic,readonly) CGFloat blue;
@property(nonatomic,readonly) CGFloat white;
@property(nonatomic,readonly) CGFloat alpha;
@property(nonatomic,readonly) CGFloat rgbHex;

+(UIColor *)randomColor;

+(UIColor *)colorWithRGBHex:(UInt32) hex;

+(UIColor *)colorWithHexString:(NSString *)stringToConvert;

+(UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;

@end
