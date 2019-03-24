//
//  UIImageView+MLBSDImageLoader.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MLBSDImageLoader)

-(void)mlb_sd_setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeHolderImageName;

-(void)mlb_sd_setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeHolderImageName cachePlaceholderImage:(BOOL)cachePlaceholderImage;

@end
