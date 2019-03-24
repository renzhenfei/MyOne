//
//  NSString+MLBUtilities.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/16.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MLBUtilities)

-(NSURL *)mlb_encodedURL;

-(NSString *)mlb_trimming;

-(NSString *)mlb_trimWhiteSpace;

-(BOOL)mlb_isEmpty;

-(NSString *)mlb_transformToPinyin;

-(BOOL)matchLetter;

-(BOOL)hasListener;

-(NSURL *)ma_iTunesURL;

-(NSString *)mlb_base64String;

-(NSString *)mlb_base64DecodeString;
//文字高度
-(CGFloat)mlb_heightWithFont:(UIFont *)font with:(CGFloat)width;
//文字宽度
-(CGFloat)mlb_widthWithFont:(UIFont *)font height:(CGFloat)height;

-(NSAttributedString *)htmlAttributedStringForMusicDetails;

/**
 给文字添加行间距

 @param text 文字
 @param lineSpacing 行间距
 @param font 字体
 @param textColor 颜色
 @return 带有行间距的文字
 */
+(NSAttributedString *)mlb_attributedStringWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)textColor;


/**
 判断包含特殊字符

 @return 是否包含特殊字符
 */
-(BOOL)mlb_containsSpecialCharacter;

@end










