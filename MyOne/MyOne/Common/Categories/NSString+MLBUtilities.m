//
//  NSString+MLBUtilities.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/16.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "NSString+MLBUtilities.h"
const NSString *ZIMU = @"^[A-Za-z]+$";
@implementation NSString (MLBUtilities)


/**
 汉子转码

 @return 转码后的文字
 */
-(NSURL *)mlb_encodedURL{
    return [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

-(NSString *)mlb_trimming{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)mlb_trimWhiteSpace{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

-(BOOL)mlb_isEmpty{
    NSString *trimStr = [self mlb_trimming];
    return !trimStr || [trimStr isEqualToString:@""];
}

-(NSString *)mlb_transformToPinyin{
    if (self.length <= 0) {
        return self;
    }
    NSString *tempString = [self mutableCopy];
    //转换成拼音
    CFStringTransform((__bridge CFMutableStringRef)tempString, NULL, kCFStringTransformToLatin, false);
    tempString = [tempString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    tempString = [tempString stringByReplacingOccurrencesOfString:@""  withString:@""];
    return [tempString uppercaseString];
}

/**
 是否是字母

 @return 是否是
 */
-(BOOL)matchLetter{
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"self matches %@",ZIMU];
    return [regextestA evaluateWithObject:self];
}


/**
 是否包含语音解析的图标

 @return 是否包含
 */
-(BOOL)hasListener{
    BOOL hasListenChar = NO;
    NSUInteger lenfth = [self length];
    unichar charBuffer[lenfth];
    [self getCharacters:charBuffer];
    for (lenfth = [self length]; lenfth > 0 ; lenfth --) {
        if (charBuffer[lenfth - 1] == 65532) {
            hasListenChar = YES;
            break;
        }
    }
    return hasListenChar;
}

-(NSURL *)ma_iTunesURL{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/id%@?mt=8",self]];
}

-(NSString *)mlb_base64String{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64DecodeString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64DecodeString;
}

-(NSString *)mlb_base64DecodeString{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *base64DecodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64DecodeString;
}
//文字高度
-(CGFloat)mlb_heightWithFont:(UIFont *)font with:(CGFloat)width{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(rect.size.height);
}
//文字宽度
-(CGFloat)mlb_widthWithFont:(UIFont *)font height:(CGFloat)height{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_DEFINED, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(rect.size.width);
}

-(NSAttributedString *)htmlAttributedStringForMusicDetails{
    NSDictionary *attributes = @{NSFontAttributeName : FontWithSize(15),
                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:&attributes error:nil];
}

/**
 给文字添加行间距
 
 @param text 文字
 @param lineSpacing 行间距
 @param font 字体
 @param textColor 颜色
 @return 带有行间距的文字
 */
+(NSAttributedString *)mlb_attributedStringWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)textColor{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attrsDictionary = @{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:paragraphStyle};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"" attributes:attrsDictionary];
    return attributedString;
}


/**
 判断包含特殊字符
 
 @return 是否包含特殊字符
 */
-(BOOL)mlb_containsSpecialCharacter{
    NSString *regex = @".*[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？].*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATHES %@",regex];
    return [pred evaluateWithObject:self];
}

@end
