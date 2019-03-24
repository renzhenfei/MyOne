//
//  UIImage+Common.m
//  MyOne
//
//  Created by zhenfei ren on 2019/1/27.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)color{
    return [self imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}

+(UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)frame{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 对图片进行尺寸压缩
 
 @param targetSize 目标大小
 @return image
 */
-(UIImage *)scaledToSize:(CGSize)targetSize{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize sourceSize = sourceImage.size;
    CGFloat scaleFactor = 1.0f;
    if (!CGSizeEqualToSize(sourceSize, targetSize)) {
        CGFloat widthFactor = targetSize.width / sourceSize.width;
        CGFloat heightFactor = targetSize.height / sourceSize.height;
        scaleFactor = MIN(widthFactor, heightFactor);
    }
    scaleFactor = MIN(scaleFactor, 1.0f);
    CGFloat targetWidth = sourceSize.width * scaleFactor;
    CGFloat targetHeight = sourceSize.height * scaleFactor;
    targetSize = CGSizeMake(targetWidth, targetHeight);
    UIGraphicsBeginImageContext(targetSize);
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage ? newImage : self;
}

-(UIImage *)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality{
    if (highQuality) {
        targetSize = CGSizeMake(2 * targetSize.width, 2 * targetSize.height);
    }
    return [self scaledToSize:targetSize];
}

-(UIImage *)scaleToMaxSize:(CGSize)size{
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat oldWidth = self.size.width;
    CGFloat oldHdight = self.size.height;
    
    CGFloat scaleFactor = oldWidth > oldHdight ? targetWidth / oldWidth : targetHeight / oldHdight;
    
    if (scaleFactor > 1.0) {
        return self;
    }
    CGFloat newHeight = oldHdight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 从相册获取图片

 @param asset 资源
 @param imgBlock 回调
 */
+(void)fullResolutionImageFromALAsset:(PHAsset *)asset imgBlock:(void(^)(UIImage* img))imgBlock{
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        UIImage *img = [UIImage imageWithData:imageData];
        if (imgBlock) {
            imgBlock(img);
        }
    }];
}

/**
 从相册获取图片

 @param asset 资源
 @param imgBlock 回调
 */
+(void)fullScreenImageAasset:(PHAsset *)asset imgBlock:(void(^)(UIImage* img))imgBlock{
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.resizeMode = PHImageRequestOptionsResizeModeNone;
    [manager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result && imgBlock) {
            imgBlock(result);
        }
    }];
}

+(UIImage *)imageWithFileType:(NSString *)fileType{
    fileType = [fileType lowercaseString];
    NSString *iconName = nil;
    if ([fileType hasPrefix:@"doc"]) {
        iconName = @"icon_file_doc";
    }else if ([fileType hasPrefix:@"ppt"]){
        iconName = @"icon_file_pdf";
    }else if ([fileType hasPrefix:@"xls"]){
        iconName = @"icon_file_xls";
    }else if ([fileType isEqualToString:@"txt"]){
        iconName = @"icon_file_txt";
    }else if ([fileType isEqualToString:@"ai"]){
        iconName = @"icon_file_ai";
    }else if ([fileType isEqualToString:@"apk"]){
        iconName = @"icon_file_apk";
    }else if ([fileType isEqualToString:@"md"]){
        iconName = @"icon_file_md";
    }else if ([fileType isEqualToString:@"psd"]){
        iconName = @"icon_file_psd";
    }else if ([fileType isEqualToString:@"zip"] || [fileType isEqualToString:@"rar"] || [fileType isEqualToString:@"arj"]) {
        iconName = @"icon_file_zip";
    }else if ([fileType isEqualToString:@"html"]
              || [fileType isEqualToString:@"xml"]
              || [fileType isEqualToString:@"java"]
              || [fileType isEqualToString:@"h"]
              || [fileType isEqualToString:@"m"]
              || [fileType isEqualToString:@"cpp"]
              || [fileType isEqualToString:@"json"]
              || [fileType isEqualToString:@"cs"]
              || [fileType isEqualToString:@"go"]) {
        iconName = @"icon_file_code";
    }else if ([fileType isEqualToString:@"avi"]
              || [fileType isEqualToString:@"rmvb"]
              || [fileType isEqualToString:@"rm"]
              || [fileType isEqualToString:@"asf"]
              || [fileType isEqualToString:@"divx"]
              || [fileType isEqualToString:@"mpeg"]
              || [fileType isEqualToString:@"mpe"]
              || [fileType isEqualToString:@"wmv"]
              || [fileType isEqualToString:@"mp4"]
              || [fileType isEqualToString:@"mkv"]
              || [fileType isEqualToString:@"vob"]) {
        iconName = @"icon_file_movie";
    }else if ([fileType isEqualToString:@"mp3"]
              || [fileType isEqualToString:@"wav"]
              || [fileType isEqualToString:@"mid"]
              || [fileType isEqualToString:@"asf"]
              || [fileType isEqualToString:@"mpg"]
              || [fileType isEqualToString:@"tti"]) {
        iconName = @"icon_file_music";
    }
    else{
        iconName = @"icon_file_unknown";
    }
    return [UIImage imageNamed:iconName];
}

+(UIImage *)mlb_imageWithName:(NSString *)imageName cached:(BOOL)cached{
    UIImage *image = nil;
    if (cached) {
        image = [UIImage imageNamed:imageName];
    }else{
        NSString *pathOfImage = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        image = [UIImage imageWithContentsOfFile:pathOfImage];
    }
    return image;
}
@end
