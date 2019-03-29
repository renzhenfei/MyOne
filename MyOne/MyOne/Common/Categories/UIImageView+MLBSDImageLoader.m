//
//  UIImageView+MLBSDImageLoader.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "UIImageView+MLBSDImageLoader.h"

@implementation UIImageView (MLBSDImageLoader)

-(void)mlb_sd_setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeHolderImageName{
    [self mlb_sd_setImageWithURL:url placeholderImageName:placeHolderImageName cachePlaceholderImage:YES];
}

-(void)mlb_sd_setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeHolderImageName cachePlaceholderImage:(BOOL)cachePlaceholderImage{
    if ([[SDImageCache sharedImageCache] diskImageExistsWithKey:url]) {
        self.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
    }else{
        UIImage *placeholderImage;
        if (IsStringNotEmpty(placeHolderImageName)) {
            if (cachePlaceholderImage) {
                placeholderImage = [UIImage imageNamed:placeHolderImageName];
            }else{
                NSString *pathOfImage = [[NSBundle mainBundle] pathForResource:placeHolderImageName ofType:@"png"];
                placeholderImage = [UIImage imageWithContentsOfFile:pathOfImage];
            }
        }
        [self sd_setImageWithURL:[url mlb_encodedURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:YES];
            });
        }];
    }
}

@end
