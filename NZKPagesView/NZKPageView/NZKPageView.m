//
//  NZKPageView.m
//  NZKPagesView
//
//  Created by developer on 17/3/20.
//  Copyright © 2017年 NiuZhengkui. All rights reserved.
//

#import "NZKPageView.h"

#define kyOrigin 54
#define kxOrigin 0
#define kDisTanceToBottom 0
#define topBarHeight 52
#define animatedBarHeight 2
#define barShadowHeight 1.0

@interface NZKPageView () 

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *animateLine;
@property (nonatomic, strong) NSArray *topBTArr;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) CGFloat oldPageHeight;
@property (nonatomic, assign) CGFloat oldOriginY;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIColor *topBKColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *btBKColor;
@property (nonatomic, strong) UIColor *btTXTColor;
@property (nonatomic, strong) UIColor *btHightTXtColor;

@end

@implementation NZKPageView

- (void)setBtBKColor:(UIColor *)btBKColor {
    _btBKColor = btBKColor;
    if (_topBTArr) {
        for (UIButton *tempBT in self.topBTArr) {
            [tempBT setBackgroundColor:btBKColor];
        }
    }
}

- (void)setBtTXTColor:(UIColor *)btTXTColor {
    _btTXTColor = btTXTColor;
    if (_topBTArr) {
        for (UIButton *tempBT in self.topBTArr) {
            [tempBT setTitleColor:btTXTColor forState:UIControlStateNormal];
        }
    }
}

- (void)setBtHightTXtColor:(UIColor *)btHightTXtColor {
    _btHightTXtColor = btHightTXtColor;
    if (_topBTArr) {
        for (UIButton *tempBT in self.topBTArr) {
            [tempBT setTitleColor:btHightTXtColor forState:UIControlStateSelected];
        }
    }
}


- (void)setTopBarBackColor:(UIColor *)backColor {
    self.topBKColor = backColor;
    if (self.topBar) {
        self.topBar.backgroundColor = backColor;
    }
}

-(void)setAnimateLineBackColor:(UIColor *)backColor {
    self.lineColor = backColor;
    if (self.animateLine) {
        self.animateLine.backgroundColor = backColor;
    }
}


- (void)setTitles:(NSArray *)titles andViews:(NSArray *)views {
    if (titles.count != views.count) {
        NSLog(@"titles and view is not have the same count");
        return ;
    }
    
    self.titles = titles;
    self.views = views;
    self.totalPage = titles.count;
    self.oldPageHeight = self.frame.size.height;
    self.oldOriginY = self.frame.origin.y;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        if (self.totalPage <= 0) {
            return ;
        }
        
        self.currentPage = 0;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kxOrigin, kyOrigin, self.bounds.size.width, self.bounds.size.height-kyOrigin)];
        self.scrollView.pagingEnabled                  = true;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.showsVerticalScrollIndicator   = false;
        self.scrollView.delegate                       = self;
        self.scrollView.contentSize = CGSizeMake(_totalPage * self.bounds.size.width, self.bounds.size.height-kyOrigin);
        self.scrollView.bounces                        = false;
        self.topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, kyOrigin)];
        self.topBar.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.animateLine = [[UIView alloc] initWithFrame:CGRectMake(0, kyOrigin-2, _topBar.bounds.size.width/_totalPage, animatedBarHeight)];
        self.animateLine.backgroundColor = [UIColor colorWithRed:0.1713 green:0.4803 blue:0.9396 alpha:1.0];
        [self addSubview:_topBar];
        [self addSubview:_scrollView];
        [self.topBar addSubview:_animateLine];
        
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_totalPage];
        for (int i = 0; i < self.totalPage; i++) {
            UIView *tempV = self.views[i];
            tempV.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height-kyOrigin);
            [self.scrollView addSubview:tempV];
            NSString *tempS = self.titles[i];
            UIButton *tempBT = [UIButton buttonWithType:UIButtonTypeCustom];
            [tempBT setTitle:tempS forState:UIControlStateNormal];
            tempBT.frame = CGRectMake(i * self.bounds.size.width/_totalPage, 0, (self.bounds.size.width - _totalPage - 1)/_totalPage, kyOrigin - 2);
            [tempBT addTarget:self action:@selector(barBTAction:) forControlEvents:UIControlEventTouchUpInside];
            [tempBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [tempBT setTitleColor:[UIColor colorWithRed:0.9216 green:0.2941 blue:0.0157 alpha:1.0] forState:UIControlStateSelected];
            if (i == 0) {
                tempBT.selected = true;
            }
            UIView *shuLine = [[UIView alloc] initWithFrame:CGRectMake(i * (self.bounds.size.width - _totalPage - 1)/_totalPage, 10, 1, topBarHeight - 20)];
            shuLine.backgroundColor = [UIColor darkGrayColor];
            [self.topBar addSubview:shuLine];
            [self.topBar addSubview:tempBT];
            [arr addObject:tempBT];
        }
        ((UIButton *)[self.topBTArr firstObject]).selected = true;
        self.topBTArr = arr;
        
        if (self.topBKColor && self.topBar) {
            [self.topBar setBackgroundColor:self.topBKColor];
        }
        if (self.lineColor && self.animateLine) {
            [self.animateLine setBackgroundColor:self.lineColor];
        }
        if (self.btBKColor && self.topBTArr) {
            for (UIButton *tempBT in self.topBTArr) {
                [tempBT setBackgroundColor:self.btBKColor];
            }
        }
        if (self.btHightTXtColor && self.topBTArr) {
            for (UIButton *tempBT in self.topBTArr) {
                [tempBT setTitleColor:self.btHightTXtColor forState:UIControlStateSelected];
            }
        }
        if (self.btTXTColor && self.topBTArr) {
            for (UIButton *tempBT in self.topBTArr) {
                [tempBT setTitleColor:self.btTXTColor forState:UIControlStateNormal];
            }
        }
        

    });
    self.oldPageHeight = self.frame.size.height;
    self.oldOriginY = self.frame.origin.y;
}

/// 按钮方法
- (void)barBTAction:(UIButton *)sender {
    NSInteger index = [self.topBTArr indexOfObject:sender];
    [self.scrollView setContentOffset:CGPointMake(index * self.bounds.size.width, 0) animated:YES];
    ((UIButton *)[self.topBTArr objectAtIndex:_currentPage]).selected = false;
    sender.selected = true;
    __block typeof(self) blockSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        blockSelf.animateLine.frame = CGRectMake(index * blockSelf.bounds.size.width / _totalPage, blockSelf.animateLine.frame.origin.y, blockSelf.animateLine.bounds.size.width, blockSelf.animateLine.bounds.size.height);
    }];
    self.currentPage = index;
    
    
    [self hidenOrShowPageHeaderV];
}

// observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self hidenOrShowPageHeaderV];
}


// MARK : - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    NSInteger index = offSet.x / self.bounds.size.width;
    ((UIButton *)[self.topBTArr objectAtIndex:_currentPage]).selected = false;
    ((UIButton *)[self.topBTArr objectAtIndex:index]).selected = true;
    __block typeof(self) blockSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        blockSelf.animateLine.frame = CGRectMake(index * blockSelf.bounds.size.width / _totalPage, blockSelf.animateLine.frame.origin.y, blockSelf.animateLine.bounds.size.width, blockSelf.animateLine.bounds.size.height);
        //        [blockSelf.scrollView setContentOffset:CGPointMake(index * blockSelf.bounds.size.width, 0)];
    }];
    self.currentPage = index;
    
    [self hidenOrShowPageHeaderV];
    
    
}

// hidenOrShowPageHeaderV

- (void)hidenOrShowPageHeaderV {
    CGPoint tableoffSet = CGPointMake(0, 0);
    if ([self.views[_currentPage] isKindOfClass:[UIScrollView class]]) {        
        UIScrollView *scrollV = (UIScrollView *)self.views[_currentPage];
        tableoffSet = scrollV.contentOffset;
    }
    NSArray *arr = self.superview.subviews;
    NSLog(@"-------(%.2f)---(%.2f)-----(%.2lu)----", tableoffSet.y, self.frame.origin.y, (unsigned long)arr.count);
    for (UIView *tempV in arr) {
        // 上划隐藏
        if (tableoffSet.y > 0 && self.frame.origin.y == self.oldOriginY) {
            NSLog(@"------上划隐藏-------------");
            if (tempV == self) {
                [UIView animateWithDuration:1 animations:^{
                    NSLog(@"------上划隐藏---self-----");
                    self.frame = CGRectMake(0, 0, self.frame.size.width, [UIScreen mainScreen].bounds.size.height);
                    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.frame.size.height - self.scrollView.frame.origin.y);
                } completion:^(BOOL finished) {
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * _totalPage, self.scrollView.frame.size.height);
                }];
                continue;
            }
            if (![tempV isKindOfClass:[UIView class]]) {
                continue;
            }
            [UIView animateWithDuration:1 animations:^{
                NSLog(@"------上划隐藏---other-----");
                tempV.frame = CGRectMake(tempV.frame.origin.x, tempV.frame.origin.y-tempV.frame.size.height, tempV.frame.size.width, tempV.frame.size.height);
            } completion:^(BOOL finished) {
                tempV.hidden = true;
            }];
        }
        // 下滑展开
        if (tableoffSet.y <= 0 && self.frame.origin.y == 0) {
            NSLog(@"------下滑展开-------------");
            if (tempV == self) {
                NSLog(@"------下滑展开---self-----");
                [UIView animateWithDuration:1 animations:^{
                    self.frame = CGRectMake(self.frame.origin.x, self.oldOriginY, self.frame.size.width, self.frame.size.height);
                    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
                } completion:^(BOOL finished) {
                    self.frame = CGRectMake(self.frame.origin.x, self.oldOriginY, self.frame.size.width, self.oldPageHeight);
                    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.oldPageHeight - self.scrollView.frame.origin.y);
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * _totalPage, self.scrollView.frame.size.height);
                }];
                continue;
            }
            if (![tempV isKindOfClass:[UIView class]]) {
                continue;
            }
            NSLog(@"------下滑展开---other-----");
            tempV.hidden = false;
            [UIView animateWithDuration:1 animations:^{
                tempV.frame = CGRectMake(tempV.frame.origin.x, tempV.frame.origin.y+tempV.frame.size.height, tempV.frame.size.width, tempV.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
