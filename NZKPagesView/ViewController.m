//
//  ViewController.m
//  NZKPagesView
//
//  Created by developer on 17/3/20.
//  Copyright © 2017年 NiuZhengkui. All rights reserved.
//

#import "ViewController.h"
#import "NZKPageView.h"
#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet NZKPageView *pageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AViewController *Avc = [[AViewController alloc] init];
    BViewController *Bvc = [[BViewController alloc] init];
    CViewController *Cvc = [[CViewController alloc] init];
    [self addChildViewController:Cvc];
    [self addChildViewController:Avc];
    [self addChildViewController:Bvc];
//    Avc.tableView.delegate = self.pageV;
//    Bvc.tableView.delegate = self.pageV;
//    [Avc addObserver:self.pageV forKeyPath:@"tableView.contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [Bvc addObserver:self.pageV forKeyPath:@"tableView.contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [Cvc addObserver:self.pageV forKeyPath:@"tableView.contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.pageV setTitles:@[@"A",@"B", @"C"] andViews:@[Avc.view, Bvc.view, Cvc.view]];
//    [self.pageV setTopBarBackColor:[UIColor colorWithRed:0.7732 green:0.7732 blue:0.7732 alpha:1.0]];
//    [self.pageV setAnimateLineBackColor:[UIColor colorWithRed:0.1875 green:1.0 blue:0.2821 alpha:1.0]];
//    [self.pageV setBtHightTXtColor:[UIColor colorWithRed:0.2471 green:0.5373 blue:0.9529 alpha:1.0]];
//    [self.pageV setBtTXTColor:[UIColor colorWithRed:0.9961 green:0.3889 blue:0.1838 alpha:1.0]];
//    [self.pageV setBtBKColor:[UIColor cyanColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
