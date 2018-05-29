//
//  YFBWGameView.m
//  YFBlackWhiteCube
//
//  Created by FYWCQ on 17/1/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFBWGameView.h"

#import "YFBWCubeView.h"

#import "YFBWHeader.h"

#import "YFBWLogic.h"

#import "HWWeakTimer.h"

@interface YFBWGameView ()

@property(nonatomic,weak)NSTimer *timer;

@end

@implementation YFBWGameView
{
    NSMutableArray * _viewArray;
    
    NSMutableArray * _stateArray;
    
    NSUInteger _rowJJ ;
    
    NSUInteger _columnII;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _viewArray = [NSMutableArray array];
        
        _stateArray = [NSMutableArray array];
        
        //    NSInteger a[4][4] = {{1,1,0,1},{1,0,1,1},{0,1,1,1},{1,1,0,1}};
        
        
        _rowJJ = 4;
        
        _columnII = 10;
        
        CGFloat width = self.frame.size.width / _rowJJ;
        
        CGFloat height = self.frame.size.height / _columnII;
        
        
        for (int i = 0; i < _columnII; i ++)
        {
            
            
            NSMutableArray * subStateArray = [[NSMutableArray alloc] init];
            
            NSMutableArray * subViewArray = [[NSMutableArray alloc] init];
            
            for (int j = 0; j < _rowJJ; j ++)
            {
                YFBWCubeView * control = [[YFBWCubeView alloc] initWithFrame:CGRectMake(j * width, i * height, width, height)];
                
                control.layer.borderColor = [UIColor blackColor].CGColor;
                
                control.layer.borderWidth = .5;
                
                control.columnII = i;
                
                control.rowJJ = j;
                
                
                control.backgroundColor = [UIColor whiteColor];
                
                [subStateArray addObject:whiteColorState];
                
                
                [control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:control];
                
                [subViewArray addObject:control];
            }
            
            [_viewArray addObject:subViewArray];
            
            [_stateArray addObject:subStateArray];
        }
    }
    return self;
}


-(void)creatTimer
{
    
    if (_timer == nil)
    {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(performGame) userInfo:nil repeats:YES];
        __weak typeof(self)weakS = self;
        _timer = [HWWeakTimer scheduledTimerWithTimeInterval:1.0 block:^(id userInfo) {
            [weakS performGame];
        } userInfo:nil repeats:YES];
    }else
    {
//        [_timer fire];
        [_timer setFireDate:[NSDate  distantPast]];// 开启定时器
    }
    
    
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    //    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //没秒执行
    //    dispatch_source_set_event_handler(_timer, ^{
    //
    //
    //
    //        if (!_stopGame)
    //        {
    //             dispatch_async(dispatch_get_main_queue(), ^{
    //
    //             [self performGame];
    //       });
    //        }
    //        else
    //        {
    //
    //
    //
    //                dispatch_source_cancel(_timer);
    //        }
    //    });
    //    dispatch_resume(_timer);
}

-(void)performGame
{
    
    if ([YFBWLogic setStateDataNN:_stateArray])// 游戏逻辑
    {
        
        NSLog(@"23323");
        
        for (int i = 0; i < _columnII; i ++)
        {
            for (int j = 0 ; j < _rowJJ; j ++)
            {
                UIControl * control = [[_viewArray objectAtIndex:i] objectAtIndex:j];
                
                
                if ([[[_stateArray objectAtIndex:i] objectAtIndex:j] isEqualToString:whiteColorState]) {
                    
                    [control setBackgroundColor:[UIColor whiteColor]];
                }
                else
                {
                    
                    [control setBackgroundColor:[UIColor blackColor]];
                }
            }
        }
    }
    else
    {
        [_timer setFireDate:[NSDate  distantFuture]];// 关闭定时器
        
        [[[UIAlertView alloc] initWithTitle:@"!!!!" message:@"You are loser!!" delegate:self cancelButtonTitle:@"再来一局" otherButtonTitles:@"我是傻逼", nil] show];
    }
}

- (void)beginGame
{
    [self creatTimer];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        NSLog(@"再来一局");
        
        [self refreshGame];
        
        [self creatTimer];
    }
    else
    {
        NSLog(@"我是傻逼");
    }
}


-(void)refreshGame
{
    for (int i = 0; i < _columnII; i ++)
    {
        for (int j = 0; j < _rowJJ; j++)
        {
            if ([[[_stateArray objectAtIndex:i] objectAtIndex:j] isEqualToString:blackColorState]) {
                
                [[_stateArray objectAtIndex:i]  replaceObjectAtIndex:j withObject:whiteColorState];
                
                UIControl * control = [[_viewArray objectAtIndex:i] objectAtIndex:j];
                
                [control setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }
    [self creatTimer];
}

-(void)controlAction:(YFBWCubeView *)control
{
    if ([[control backgroundColor] isEqual:[UIColor blackColor]])
    {
        [control setBackgroundColor:[UIColor whiteColor]];
        
        [[_stateArray objectAtIndex:control.columnII] replaceObjectAtIndex:control.rowJJ withObject:whiteColorState];
    }
}

@end
