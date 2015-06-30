//
//  SlideTabBarView.h
//  SlideTabBar
//
//  Created by Mr.LuDashi on 15/6/25.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideTabBarView : UIView

@property (assign) NSInteger tabCount;
-(instancetype)initWithFrame:(CGRect)frame WithCount: (NSInteger) count;
@end
