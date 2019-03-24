//
//  MLBSerialCollectionView.h
//  MyOne
//
//  Created by zhenfei ren on 2019/3/22.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBBaseView.h"
@class MLBReadSerial;

@interface MLBSerialCollectionView : MLBBaseView

@property(nonatomic,strong)MLBReadSerial *readSerail;
@property(nonatomic,copy) void (^didSelectedSerial)(MLBReadSerial *readSerail);

-(void)show;

-(void)dismiss;

-(void)dismissWithCompleted:(void(^)(void))completedBlock;

@end
