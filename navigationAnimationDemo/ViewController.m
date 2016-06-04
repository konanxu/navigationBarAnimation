//
//  ViewController.m
//  navigationAnimationDemo
//
//  Created by Konan on 16/6/4.
//  Copyright © 2016年 avantouch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_imageView;
    UIImageView *_barImageView;
}
@property (strong, nonatomic) IBOutlet UITableView *tbView;

@end

static NSString * const cellId = @"kCellId";
static NSString * const title = @"14松さん";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
//    self.title = title;
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"14matsu.jpg"]];
    _imageView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 260);
    self.tbView.tableHeaderView = _imageView;
    
    [self.tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    
    //设置navigation透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
    NSLog(@"%@",self.navigationController.navigationBar.subviews);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 原理解析：起点 - 64  终点 200 偏移  滑到位置除以总位置获取占1的多少。
    
    CGFloat minAlphaOffset = - 64;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    _barImageView.alpha = alpha;
    self.title = alpha >= 1 ?  title: @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
