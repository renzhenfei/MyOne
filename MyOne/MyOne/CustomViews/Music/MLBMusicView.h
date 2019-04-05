//
//  MLBMusicView.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/29.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseView.h"

FOUNDATION_EXPORT NSString *const KMLMusicViewID;

@interface MLBMusicView : MLBBaseView

-(void)prepareForReuse;

-(void)configureViewWithMusicId:(NSString *)musicId viewIndex:(NSInteger)viewIndex;

-(void)configureViewWithMusicId:(NSString *)musicId viewIndex:(NSInteger)viewIndex inViewController:(UIViewController *)inViewController;

@end
