//
//  MLBReadBaseView.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/17.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseView.h"

FOUNDATION_EXPORT NSString *const KMLReadBaseViewID;

@class MLBReadEssay;
@class MLBReadSerial;
@class MLBReadQuestion;
@class MLBBaseViewController;
@interface MLBReadBaseView : MLBBaseView

@property(nonatomic,copy) void (^readSelected)(MLBReadType type,NSInteger index);

- (void)configureViewWithReadEssay:(MLBReadEssay *)readEssay readSerial:(MLBReadSerial *)readSerial readQuestion:(MLBReadQuestion *)readQuestion atIndex:(NSInteger)index;

-(void)configireViewWithReadEssay:(MLBReadEssay *)readEssay readSerial:(MLBReadSerial *)readSerial readQuestion:(MLBReadQuestion *)readQuestion atIndex:(NSInteger)index inViewController:(MLBBaseViewController *)parentViewController;

@end
