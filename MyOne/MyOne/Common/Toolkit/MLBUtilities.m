//
//  MLBUtilities.m
//  MyOne
//
//  Created by zhenfei ren on 2019/1/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBUtilities.h"

static NSDateFormatter *myOneDateFormatter;
static NSDateFormatter *longDateFormatter;
static NSDateFormatter *readDetailDateFormatter;
static NSDateFormatter *musicDetailDateFormatter;
static NSDateFormatter *commentDetailDateFormatter;

@implementation MLBUtilities

+(NSString *)stringDateFormatWithddMMyyyyEEEByNormalDateString:(NSString *)normalDateString{
    if (!myOneDateFormatter) {
        myOneDateFormatter = [NSDateFormatter new];
        myOneDateFormatter.dateFormat = @"EEE dd MM. yyyy";
        myOneDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    }
    NSDate *date = [MLBUtilities dateWithString:normalDateString];
    return [myOneDateFormatter stringFromDate:date];
}

+(NSString *)stringDateFormatWithEEEddMMyyyyByNormalDateString:(NSString *)normalDateString{
    if (!myOneDateFormatter) {
        myOneDateFormatter = [NSDateFormatter new];
        myOneDateFormatter.dateFormat = @"EEE dd MMM. yyyy";
        myOneDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    }
    NSDate *date = [MLBUtilities dateWithString:normalDateString];
    return [myOneDateFormatter stringFromDate:date];
}

+(NSString *)stringDateForReadDetailsDateString:(NSString *)normalDateString{
    if (!readDetailDateFormatter) {
        readDetailDateFormatter = [NSDateFormatter new];
        readDetailDateFormatter.dateFormat = @"MMM. dd,yyyy";
        readDetailDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    }
    NSDate *date = [self dateWithString:normalDateString];
    return [readDetailDateFormatter stringFromDate:date];
}

+(NSString *)stringDateForMusicDetailsDateString:(NSString *)normalDateString{
    if (!musicDetailDateFormatter) {
        musicDetailDateFormatter = [NSDateFormatter new];
        musicDetailDateFormatter.dateFormat = @"MMM dd,yyyy";
        musicDetailDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    }
    NSDate *date = [self dateWithString:normalDateString];
    return [musicDetailDateFormatter stringFromDate:date];
}

+(NSString *)stringDateForCommentDateString:(NSString *)normalDateString{
    if (!commentDetailDateFormatter) {
        commentDetailDateFormatter = [NSDateFormatter new];
        commentDetailDateFormatter.dateFormat = @"yyyy.MM.dd";
        commentDetailDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    }
    NSDate *date = [self dateWithString:normalDateString];
    return [commentDetailDateFormatter stringFromDate:date];
}

+(NSString *)appCurrentVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(NSString *)appCurrentBuild{
    return [[[NSBundle mainBundle] infoDictionary]objectForKey:(NSString *)kCFBundleVersionKey];
}

+(NSAttributedString *)mlb_attributedStringWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)textColor{
    return [self mlb_attributedStringWithText:text lineSpacing:lineSpacing font:font textColor:textColor lineBreakMode:NSLineBreakByWordWrapping];
}

+(NSAttributedString *)mlb_attributedStringWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)textColor lineBreakMode:(NSLineBreakMode)lineBreadMode{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = lineBreadMode;
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName : font,NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName : paragraphStyle};
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:text attributes:attrsDictionary];
    return attributeString;
}

+(CGRect)mlb_rectWithAttributedString:(NSAttributedString *)attributedString size:(CGSize)size{
    CGRect rect = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect;
}

#pragma mark - Int

+(NSInteger)rowWithCount:(NSInteger)count colNumber:(NSInteger)colNumber{
    return ceilf((CGFloat)count / colNumber);
}

#pragma mark - Date / 日期
+(NSDate *)dateWithString:(NSString *)string{
    if (!longDateFormatter) {
        longDateFormatter = [NSDateFormatter new];
        longDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        longDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    }
    return [longDateFormatter dateFromString:string];
}

+(NSTimeInterval)diffTimeIntervalSinceNowFromDateString:(NSString *)dateString{
    NSDate *date = [self dateWithString:dateString];
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    return timeInterval;
}

+(NSTimeInterval)difftimeIntervalSinceNowToDateString:(NSString *)dateString{
    NSDate *date = [self dateWithString:dateString];
    NSDate *now = [NSDate date];
    return [date timeIntervalSinceDate:now];
}

@end
