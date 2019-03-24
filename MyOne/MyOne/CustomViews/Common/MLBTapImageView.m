//
//  MLBTapImageView.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBTapImageView.h"

@interface MLBTapImageView ()

@property (copy, nonatomic) TapAction tapAction;

@end


@implementation MLBTapImageView

- (void)dealloc {
    DDLogDebug(@"%@ - %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)tap {
    if (self.tapAction) {
        self.tapAction(self);
    }
}

- (void)addTapBlock:(TapAction)tapAction {
    self.tapAction = tapAction;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

- (void)setImageWithURL:(NSString *)imgURL placeholderImageName:(NSString *)placeholderImageName tapBlock:(TapAction)tapAction {
    [self mlb_sd_setImageWithURL:imgURL placeholderImageName:placeholderImageName];
    [self addTapBlock:tapAction];
}

@end
