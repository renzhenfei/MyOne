//
//  UIView+Frame.m
//  MyOne
//
//  Created by zhenfei ren on 2019/1/27.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
}

- (CGFloat)with{
    return self.frame.size.width;
}

- (void)setWith:(CGFloat)with{
    CGRect rect = self.frame;
    rect.size.width = with;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top{
    CGRect rect = self.frame;
    rect.origin.x = top;
    self.frame = rect;
}

- (CGFloat)bottom{
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect rect = self.frame;
    rect.origin.y = bottom - self.height;
    self.frame = rect;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left{
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (CGFloat)right{
    return self.left + self.with;
}

- (void)setRight:(CGFloat)right{
    CGRect rect = self.frame;
    rect.origin.x = right - self.with;
    self.frame = rect;
}



@end
