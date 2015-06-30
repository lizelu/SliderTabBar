//
//  ViewController.m
//  SlideTabBar
//
//  Created by Mr.LuDashi on 15/6/25.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "ViewController.h"
#import "SlideTabBarView.h"

@interface ViewController ()

@property (strong, nonatomic) SlideTabBarView *slideTabBarView;
@property (strong, nonatomic) IBOutlet UIView *superView;
@property (assign) NSInteger tabCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabCount = 6;
    [self initSlideWithCount:_tabCount];
}

- (IBAction)jian:(id)sender {
    [_slideTabBarView removeFromSuperview];
    if (_tabCount > 1) {
        [self initSlideWithCount:--_tabCount];
    }
    
}


- (IBAction)add:(id)sender {
    [_slideTabBarView removeFromSuperview];
    
    [self initSlideWithCount:++_tabCount];
}

-(void) initSlideWithCount: (NSInteger) count{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    screenBound.origin.y = 60;
    
    _slideTabBarView = [[SlideTabBarView alloc] initWithFrame:screenBound WithCount:count];
    [self.view addSubview:_slideTabBarView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
