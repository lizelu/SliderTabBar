//
//  SlideTabBarView.m
//  SlideTabBar
//
//  Created by Mr.LuDashi on 15/6/25.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "SlideTabBarView.h"
#import "SlideBarCell.h"
#define TOPHEIGHT 60
@interface SlideTabBarView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
///@brife 整个视图的大小
@property (assign) CGRect mViewFrame;

///@brife 下方的ScrollView
@property (strong, nonatomic) UIScrollView *scrollView;

///@brife 上方的按钮数组
@property (strong, nonatomic) NSMutableArray *topViews;

///@brife 下方的表格数组
@property (strong, nonatomic) NSMutableArray *scrollTableViews;

///@brife TableViews的数据源
@property (strong, nonatomic) NSMutableArray *dataSource;

///@brife 当前选中页数
@property (assign) NSInteger currentPage;

///@brife 下面滑动的View
@property (strong, nonatomic) UIView *slideView;
@end

@implementation SlideTabBarView

-(instancetype)initWithFrame:(CGRect)frame WithCount: (NSInteger) count{
    self = [super initWithFrame:frame];
    
    if (self) {
        _mViewFrame = frame;
        _tabCount = count;
        _topViews = [[NSMutableArray alloc] init];
        _scrollTableViews = [[NSMutableArray alloc] init];
        
        [self initDataSource];
        
        [self initScrollView];
        
        [self initTopTabs];
        
        [self initDownTables];
        
        [self initDataSource];
        
        [self initSlideView];
        
    }
    
    return self;
}


#pragma mark -- 初始化滑动的指示View
-(void) initSlideView{
     CGFloat width = _mViewFrame.size.width / _tabCount;
    _slideView = [[UIView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT - 5, width, 5)];
    [_slideView setBackgroundColor:[UIColor redColor]];
    [self addSubview:_slideView];
}


#pragma mark -- 初始化表格的数据源
-(void) initDataSource{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:_tabCount];
    
    for (int i = 1; i <= _tabCount; i ++) {
        
        NSMutableArray *tempArray  = [[NSMutableArray alloc] initWithCapacity:20];
        
        for (int j = 1; j <= 20; j ++) {
            
            NSString *tempStr = [NSString stringWithFormat:@"我是第%d个TableView的第%d条数据。", i, j];
            [tempArray addObject:tempStr];
        }
        
        [_dataSource addObject:tempArray];
    }
}


#pragma mark -- 实例化ScrollView
-(void) initScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _mViewFrame.origin.y, _mViewFrame.size.width, _mViewFrame.size.height - TOPHEIGHT)];
    _scrollView.contentSize = CGSizeMake(_mViewFrame.size.width * _tabCount, _mViewFrame.size.height - 60);
    _scrollView.backgroundColor = [UIColor grayColor];
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}



#pragma mark -- 实例化顶部的tab
-(void) initTopTabs{
    CGFloat width = _mViewFrame.size.width / _tabCount;
    
    for (int i = 0; i < _tabCount; i ++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, TOPHEIGHT)];
        
        view.backgroundColor = [UIColor lightGrayColor];
        
        if (i % 2) {
            view.backgroundColor = [UIColor grayColor];
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, TOPHEIGHT)];
        button.tag = i;
        [button setTitle:[NSString stringWithFormat:@"按钮%d", i+1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tabButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        [_topViews addObject:view];
        [self addSubview:view];
    }
}



#pragma mark --点击顶部的按钮所触发的方法
-(void) tabButton: (id) sender{
    UIButton *button = sender;
    [_scrollView setContentOffset:CGPointMake(button.tag * _mViewFrame.size.width, 0) animated:YES];
}

#pragma mark --初始化下方的TableViews
-(void) initDownTables{
    
    for (int i = 0; i < _tabCount; i ++) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * _mViewFrame.size.width, 0, _mViewFrame.size.width, _mViewFrame.size.height - TOPHEIGHT)];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [_scrollTableViews addObject:tableView];
        [_scrollView addSubview:tableView];
    }

}


#pragma mark -- scrollView的代理方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    _currentPage = _scrollView.contentOffset.x/_mViewFrame.size.width;
    
    UITableView *currentTable = _scrollTableViews[_currentPage];
    [currentTable reloadData];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_scrollView isEqual:scrollView]) {
        CGRect frame = _slideView.frame;
        frame.origin.x = scrollView.contentOffset.x/_tabCount;
        _slideView.frame = frame;
    }
}





#pragma mark -- talbeView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *tempArray = _dataSource[_currentPage];
    return tempArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib *nib=[UINib nibWithNibName:@"SlideBarCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"SlideBarCell"];
        nibsRegistered=YES;
    }
    
    
    SlideBarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SlideBarCell"];
    if ([tableView isEqual:_scrollTableViews[_currentPage]]) {
         cell.tipTitle.text = _dataSource[_currentPage][indexPath.row];
    }
   
    return cell;
}
@end
