//
//  AViewController.m
//  NZKPagesView
//
//  Created by developer on 17/3/20.
//  Copyright © 2017年 NiuZhengkui. All rights reserved.
//

#import "AViewController.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.327 green:0.6774 blue:0.8869 alpha:1.0];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aaa"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return  1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 30;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"aaa" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString  stringWithFormat:@"AAA%ld", (long)indexPath.row];
//    return  cell;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
