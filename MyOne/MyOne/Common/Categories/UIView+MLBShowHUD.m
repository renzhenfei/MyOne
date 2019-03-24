//
//  UIView+MLBShowHUD.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/14.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "UIView+MLBShowHUD.h"

@implementation UIView (MLBShowHUD)

#pragma mark - Private Method

-(MBProgressHUD *)hudWithModel:(MBProgressHUDMode)mode{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = mode;
    hud.removeFromSuperViewOnHide = YES;
    hud.delegate = self;
    return hud;
}

#pragma mark - Delegate

/**
 * Called after the HUD was fully hidden from the screen.
 */
- (void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
}

#pragma mark - @override Method

/**
 按照显示的文字计算 hud 显示的时间长度
 
 @param text 显示的文字
 @return 显示的时间长短
 */
-(CGFloat)timeForHUDHideDelayWithText:(NSString *)text{
    CGFloat stringTime = [text mlb_trimming].length / 5.0 * 1.0;
    return MIN(3, MAX(HUD_DELAY, stringTime));
}

/**
 隐藏 HUD
 */
-(void)hideHUD{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (hud && !hud.isHidden) {
        [hud hideAnimated:YES];
    }
}


/**
 只显示文字的HUD
 
 @param text 显示的文字
 */
-(void)showHUDOnlyText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (!hud) {
        hud = [self hudWithModel:MBProgressHUDModeText];
    }else{
        hud.mode = MBProgressHUDModeText;
    }
    hud.detailsLabel.text = text;
    [hud hideAnimated:YES afterDelay:[self timeForHUDHideDelayWithText:text]];
}

/**
 显示网络异常的hud
 */
-(void)showHUDNetError{
    [self showHUDErrorWithText:BAD_NETWORK];
}


/**
 显示服务器连接失败的hud
 */
-(void)showHUDServerError{
    [self showHUDErrorWithText:SERVER_ERROR];
}

/**
 显示网络异常并显示http code
 
 @param statusCode 状态码
 */
-(void)showHUDNetErrorWithStatusCode:(NSInteger)statusCode{
    [self showHUDErrorWithText:[NSString stringWithFormat:@"%@,Code:%ld",SERVER_ERROR,statusCode]];
}


/**
 显示错误信息HUD
 
 @param text 错误信息
 */
-(void)showHUDErrorWithText:(NSString *)text{
    [self showHUDWithImageName:@"common_icon_error" text:text];
}


/**
 显示成功的hud
 */
-(void)showHUDSuccess{
    [self showHUDSuccessWithText:@"成功"];
}


/**
 显示成功信息的hud
 
 @param text 成功信息
 */
-(void)showHUDSuccessWithText:(NSString *)text{
    [self showHUDWithImageName:@"common_icon_completed" text:text];
}


/**
 显示指定图片和文字hud
 
 @param imageName 图片名字
 @param text 文字
 */
-(void)showHUDWithImageName:(NSString *)imageName text:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (!hud) {
        hud = [self hudWithModel:MBProgressHUDModeCustomView];
    }else{
        hud.mode = MBProgressHUDModeCustomView;
    }
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = NO;
    hud.detailsLabel.text = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.delegate = self;
    [hud hideAnimated:YES afterDelay:[self timeForHUDHideDelayWithText:text]];
}


/**
 显示等待的hud
 
 @param text 等待信息
 */
-(void)showHUDWaitWithText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (!hud) {
        hud = [self hudWithModel:MBProgressHUDModeIndeterminate];
    }else{
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    hud.removeFromSuperViewOnHide = YES;
    hud.delegate = self;
    hud.detailsLabel.text = text;
}


/**
 显示model转换失败的hud
 
 @param error 错误信息
 */
-(void)showHUDModelTransformFailedWithError:(NSError *)error{
    [self showHUDErrorWithText:@"JSON 转 Model 失败"];
    DDLogDebug(@"error = %@",error);
}

@end
