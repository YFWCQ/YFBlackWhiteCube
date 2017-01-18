//
//  YFBWLogic.m
//  YFBlackWhiteCube
//
//  Created by FYWCQ on 17/1/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFBWLogic.h"

#import "YFBWHeader.h"

@implementation YFBWLogic


// 复用 array 里最后一个数组 比不服用的方法 效率高 只是第一次耗时多 以后明显优于不服用的方法
+(BOOL)setStateData:(NSMutableArray *)array
{
    NSMutableArray * lastArray = [array firstObject];
    
    int random = arc4random() % lastArray.count;
    
    for (int i = 0; i <lastArray.count; i ++ )
    {
        if ([[lastArray objectAtIndex:i] isEqualToString:blackColorState])
        {
            return NO;
        }
        else
        {
            if (random == i)
            {
                [lastArray replaceObjectAtIndex:i withObject:blackColorState];
            }
        }
    }
    
    [array removeObjectAtIndex:0];
    
    [array addObject:lastArray];
    
    return YES;
}



// 复用 array 里最后一个数组 比不服用的方法 效率高 只是第一次耗时多 以后明显优于不服用的方法
+(BOOL)setStateDataNN:(NSMutableArray *)array
{
    NSMutableArray * firstArray = [array lastObject];
    
    int random = arc4random() % firstArray.count;
    
    for (int i = 0; i <firstArray.count; i ++ )
    {
        if ([[firstArray objectAtIndex:i] isEqualToString:blackColorState])
        {
            return NO;
        }
        else
        {
            if (random == i)
            {
                [firstArray replaceObjectAtIndex:i withObject:blackColorState];
            }
        }
    }
    
    [array removeLastObject];
    
    [array insertObject:firstArray atIndex:0];
    
    return YES;
}


// 不复用 array 最后一个数组 新建一个数组//0.000011s 耗时多
+(void)setStateDataNNnn:(NSMutableArray *)array
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSInteger arrayCount = [(NSArray *)[array objectAtIndex:0] count];
    
    [array removeObjectAtIndex:0];
    
    NSMutableArray * lastArray =[NSMutableArray array];
    
    int random = arc4random() % arrayCount;
    
    for (int i = 0; i <arrayCount; i ++ )
    {
        if (random != i)
        {
            [lastArray addObject:whiteColorState];
        }
        else
        {
            [lastArray addObject:blackColorState];
        }
    }
    
    [array addObject:lastArray];
    
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    
    NSLog(@" 计算 读取 城市列表  所耗时间  %fs",endTime - startTime);
}


@end
