//
//  MLBBaseView.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/3.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseView.h"

@implementation MLBBaseView

- (void)dealloc
{
    DDLogDebug(@"%@ - %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
