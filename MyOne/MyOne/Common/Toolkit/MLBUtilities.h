//
//  MLBUtilities.h
//  MyOne
//
//  Created by zhenfei ren on 2019/1/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLBUtilities : NSObject

+(NSString *)stringDateFormatWithddMMyyyyEEEByNormalDateString:(NSString *)normalDateString;

+(NSString *)stringDateFormatWithEEEddMMyyyyByNormalDateString:(NSString *)normalDateString;

+(NSString *)stringDateForReadDetailsDateString:(NSString *)normalDateString;

+(NSString *)stringDateForMusicDetailsDateString:(NSString *)normalDateString;

+(NSString *)stringDateForCommentDateString:(NSString *)normalDateString;

+(NSString *)appCurrentVersion;

+(NSString *)appCurrentBuild;

+(NSAttributedString *)mlb_attributedStringWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)textColor;

+(NSAttributedString *)mlb_attributedStringWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)textColor lineBreakMode:(NSLineBreakMode)lineBreadMode;

+(CGRect)mlb_rectWithAttributedString:(NSAttributedString *)attributedString size:(CGSize)size;

#pragma mark - Int

+(NSInteger)rowWithCount:(NSInteger)count colNumber:(NSInteger)colNumber;

#pragma mark - Date / 日期
+(NSDate *)dateWithString:(NSString *)string;

+(NSTimeInterval)diffTimeIntervalSinceNowFromDateString:(NSString *)dateString;

+(NSTimeInterval)difftimeIntervalSinceNowToDateString:(NSString *)dateString;


@end
