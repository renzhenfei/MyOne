//
//  MLBReadDetailsView.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/21.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseView.h"
@class MLBBaseModel;

FOUNDATION_EXPORT NSString *const KMLReadDetailsID;

@interface MLBReadDetailsView : MLBBaseView

-(void)prepareForReuseWithViewType:(MLBReadType)type;

-(void)configureViewWithReadModel:(MLBBaseModel *)model type:(MLBReadType)type atIndex:(NSInteger)index inViewController:(MLBBaseViewController *)parentViewController;

@end
