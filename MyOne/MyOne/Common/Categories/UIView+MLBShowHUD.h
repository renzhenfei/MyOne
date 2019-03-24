//
//  UIView+MLBShowHUD.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/14.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface UIView (MLBShowHUD)<MBProgressHUDDelegate>


/**
 按照显示的文字计算 hud 显示的时间长度

 @param text 显示的文字
 @return 显示的时间长度
 */
-(CGFloat)timeForHUDHideDelayWithText:(NSString *)text;

/**
 隐藏 HUD
 */
-(void)hideHUD;


/**
 只显示文字的HUD

 @param text 显示的文字
 */
-(void)showHUDOnlyText:(NSString *)text;

/**
 显示网络异常的hud
 */
-(void)showHUDNetError;


/**
 显示服务器连接失败的hud
 */
-(void)showHUDServerError;

/**
 显示网络异常并显示http code

 @param statusCode 状态码
 */
-(void)showHUDNetErrorWithStatusCode:(NSInteger)statusCode;

/**
 显示错误信息HUD

 @param text 错误信息
 */
-(void)showHUDErrorWithText:(NSString *)text;


/**
 显示成功的hud
 */
-(void)showHUDSuccess;


/**
 显示成功信息的hud

 @param text 成功信息
 */
-(void)showHUDSuccessWithText:(NSString *)text;


/**
 显示指定图片和文字hud

 @param imageName 图片名字
 @param text 文字
 */
-(void)showHUDWithImageName:(NSString *)imageName text:(NSString *)text;


/**
 显示等待的hud

 @param text 等待信息
 */
-(void)showHUDWaitWithText:(NSString *)text;


/**
 显示model转换失败的hud

 @param error 错误信息
 */
-(void)showHUDModelTransformFailedWithError:(NSError *)error;
@end


















