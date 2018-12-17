//
//  ViewController.m
//  TestUItabelViewCellShow
//
//  Created by Steven on 2018/12/17.
//  Copyright © 2018 Steven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUP];
}

-(void)setUP{
    self.edgesForExtendedLayout = UIRectEdgeNone; //默认布局从导航栏下开始
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];//空白处理
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//线隐藏
    
    //添加线的
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.showsHorizontalScrollIndicator = NO; //隐藏下滑
    self.tableView.showsVerticalScrollIndicator = NO; //隐藏条

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    
    //无选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(float_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^
    {
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rectInSuperview = [tableView convertRect:rectInTableView toView:[tableView superview]];
        if ( rectInSuperview.origin.y > [UIScreen mainScreen].bounds.size.height || rectInSuperview.origin.y + rectInSuperview.size.height < 0 ) {
        }else{
            // 对未移出屏幕的 Cell 做相应的处理
            NSString *str = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
            NSLog(@"十年后 ---cell还是深爱着屏幕-%@",str);

        }
    });
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 106;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
}

//-(void)s

@end
