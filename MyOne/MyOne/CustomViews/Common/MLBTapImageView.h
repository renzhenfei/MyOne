//
//  MLBTapImageView.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapAction)(id obj);

@interface MLBTapImageView : UIImageView

- (void)addTapBlock:(TapAction)tapAction;

- (void)setImageWithURL:(NSString *)imgURL placeholderImageName:(NSString *)placeholderImageName tapBlock:(TapAction)tapAction;

@end
