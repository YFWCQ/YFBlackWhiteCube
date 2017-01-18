//
//  YFBWLogic.h
//  YFBlackWhiteCube
//
//  Created by FYWCQ on 17/1/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFBWLogic : NSObject

/**
 * 从下往上
 */
+(BOOL)setStateData:(NSMutableArray *)array;

/**
 * 从上往下
 */
+(BOOL)setStateDataNN:(NSMutableArray *)array;

@end
