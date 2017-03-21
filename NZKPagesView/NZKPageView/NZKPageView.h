//
//  NZKPageView.h
//  NZKPagesView
//
//  Created by developer on 17/3/20.
//  Copyright © 2017年 NiuZhengkui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZKPageView : UIView <UIScrollViewDelegate>

- (void)setBtBKColor:(UIColor *)btBKColor;
- (void)setBtTXTColor:(UIColor *)btTXTColor;
- (void)setBtHightTXtColor:(UIColor *)btHightTXtColor;
- (void)setTopBarBackColor:(UIColor *)backColor;
- (void)setAnimateLineBackColor:(UIColor *)backColor;
- (void)setTitles:(NSArray *)titles andViews:(NSArray *)views;

@end
