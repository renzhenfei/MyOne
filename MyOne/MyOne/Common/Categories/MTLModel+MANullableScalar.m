//
//  MTLModel+MANullableScalar.m
//  MyOne
//
//  Created by zhenfei ren on 2019/2/23.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MTLModel+MANullableScalar.h"

@implementation MTLModel (MANullableScalar)

-(void)setNilValueForKey:(NSString *)key{
    [self setValue:@0 forKey:key];
}

@end
