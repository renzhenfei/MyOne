//
//  UIImage+Common.h
//  MyOne
//
//  Created by zhenfei ren on 2019/1/27.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)color;

+(UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)frame;

-(UIImage *)scaledToSize:(CGSize)targetSize;

-(UIImage *)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;

-(UIImage *)scaleToMaxSize:(CGSize)size;

+(void)fullResolutionImageFromALAsset:(PHAsset *)asset imgBlock:(void(^)(UIImage* img))imgBlock;

+(void)fullScreenImageAasset:(PHAsset *)asset imgBlock:(void(^)(UIImage* img))imgBlock;

+(UIImage *)imageWithFileType:(NSString *)fileType;

+(UIImage *)mlb_imageWithName:(NSString *)imageName cached:(BOOL)cached;

@end
