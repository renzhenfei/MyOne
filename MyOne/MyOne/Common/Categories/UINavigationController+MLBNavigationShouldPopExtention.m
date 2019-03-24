//
//  UINavigationController+MLBNavigationShouldPopExtention.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/19.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "UINavigationController+MLBNavigationShouldPopExtention.h"
#import "objc/runtime.h"
@implementation UINavigationController (MLBNavigationShouldPopExtention)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(navigationBar:shouldPopItem:);
        SEL swizzledSelector = @selector(mlb_navigationBar:shouldPopItem:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

-(BOOL)mlb_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    UIViewController *vc = [self topViewController];
    if (item != vc.navigationItem) {
        return YES;
    }
    if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
        if ([(id<UINavigationControllerShouldPop>)vc navigationControllerShouldPop:self]) {
            return [self mlb_navigationBar:navigationBar shouldPopItem:item];
        }else{
            return NO;
        }
    }else{
        return [self mlb_navigationBar:navigationBar shouldPopItem:item];
    }
    return YES;
}

@end
