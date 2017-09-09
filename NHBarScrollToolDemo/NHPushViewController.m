//
//  NHPushViewController.m
//  NHBarScrollToolDemo
//
//  Created by neghao on 2017/8/8.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "NHPushViewController.h"
#import "NHBarScrollTool.h"
#import <MJRefresh.h>
#import "UIView+NHFrame.h"


@interface NHPushViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *navigationBar;
@property (weak, nonatomic) IBOutlet UIView *tabBar;
@property (nonatomic, strong) NHBarScrollTool *barScrollTool;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NHPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];

}

- (NHBarScrollTool *)barScrollTool {
    if (!_barScrollTool) {
        _barScrollTool = [NHBarScrollTool BarScrollToolWithController:self
                                                           scrollView:_tableView
                                                        navigationBar:_navigationBar
                                                               tabBar:_tabBar];
        _barScrollTool.delegateTargets = @[ self ];
    }
    return _barScrollTool;
}

- (void)setupTableView {
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self.barScrollTool;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2 * NSEC_PER_SEC), dispatch_queue_create("head", NULL), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
            });
        });
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2 * NSEC_PER_SEC), dispatch_queue_create("head", NULL), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_footer endRefreshing];
            });
        });
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%s  contentOffsetY:%f",__func__,scrollView.contentOffset.y);
    
}



@end
