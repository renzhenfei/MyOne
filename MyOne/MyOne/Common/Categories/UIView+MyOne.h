//
//  UIView+MyOne.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MLBPopMenuType){
    MLBPopMenuTypeWechatFrined,// 微信好友
    MLBPopMenuTypeMoments,// 朋友圈
    MLBPopMenuTypeWeibo,// 微博
    MLBPopMenuTypeQQ,// QQ
    MLBPopMenuTypeCopyURL,// 复制链接
    MLBPopMenuTypeFavorite,// 收藏
};
typedef void(^MenuSelectedBlock)(MLBPopMenuType menuType);

@interface UIView (MyOne)

/**
 显示分享菜单

 @param block 点击回调
 */
-(void)mlb_showPopMenuViewWithMenuSelectedBlock:(MenuSelectedBlock)block;


/**
 展示图片

 @param image 要展示的图片
 @param referenceRect 尺寸大小
 @param referenceView 父视图
 */
-(void)blowUpImage:(UIImage *)image referenceRect:(CGRect)referenceRect referenceView:(UIView *)referenceView;

@end
