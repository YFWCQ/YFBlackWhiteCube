//
//  ViewController.m
//  YFBlackWhiteCube
//
//  Created by FYWCQ on 17/1/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "ViewController.h"

#import "YFBWGameView.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YFBWGameView *gameView = [[YFBWGameView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:gameView];
    
    [gameView beginGame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
