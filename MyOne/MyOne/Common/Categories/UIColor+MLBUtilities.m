//
//  UIColor+MLBUtilities.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/12.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "UIColor+MLBUtilities.h"

@implementation UIColor (MLBUtilities)

+(UIColor *)randomColor {
    return [UIColor colorWithRed:(arc4random()%256)/256.f green:(arc4random()%256)/256.f blue:(arc4random()%256)/256.f alpha:1.0f];
}

+(UIColor *)colorWithRGBHex:(UInt32) hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = hex & 0xFF;
    return [UIColor colorWithRed:r / 255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}

+(UIColor *)colorWithHexString:(NSString *)stringToConvert{
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [UIColor colorWithRGBHex:hexNum];
}

+(UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha{
    UIColor *color = [UIColor colorWithHexString:stringToConvert];
    return [UIColor colorWithRed:color.red green:color.green blue:color.blue alpha:alpha];
}

#pragma mark - Publish Method

-(CGColorSpaceModel)colorSpaceModel{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

-(BOOL)canProvideRGBComponents{
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
            break;
        default:
            return NO;
            break;
    }
}


-(BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r,g,b,a;
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
        default:
            return NO;
            break;
    }
    if(red) *red = r;
    if(blue) *blue = b;
    if(green) *green = g;
    if(alpha) *alpha = a;
    return YES;
}

- (CGFloat)red{
    NSAssert(self.canProvideRGBComponents, @"must be an rgb color to use -red");
    const CGFloat* c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green{
    NSAssert(self.canProvideRGBComponents, @"must be an rgb color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
    return c[1];
}

- (CGFloat)blue{
    NSAssert(self.canProvideRGBComponents, @"must be an rgb color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
    return c[2];
}

- (CGFloat)white{
    NSAssert(self.canProvideRGBComponents, @"must be an Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)alpha{
    return CGColorGetAlpha(self.CGColor);
}

- (CGFloat)rgbHex{
    NSAssert(self.canProvideRGBComponents, @"must be an Monochrome color to use -rgbhex");
    CGFloat r,g,b,a;
    if (![self getRed:&r green:&g blue:&b alpha:&a]) {
        return 0;
    }
    r = MIN(MAX(self.red, 0.0f), 1.0f);
    g = MIN(MAX(self.green, 0.0f), 1.0f);
    b = MIN(MAX(self.blue, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 16)
    | (((int)roundf(b * 255)) << 16);
}
@end



















