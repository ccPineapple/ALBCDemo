//
//  ViewController.m
//  ALBCDemo
//
//  Created by 路洪宇 on 2016/11/8.
//  Copyright © 2016年 路洪宇. All rights reserved.
//

#import "ViewController.h"
#import <NBSDK/ALiTradeSDK.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_array;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _array = @[@"跳转商品",@"跳转店面"];
    [self buildTableView];
    
    /*
     1.换Bundle ID 对应 安全图片
     2.换Bundle ID 对应 appKey
     3.换Bundle ID
    */
}

#pragma mark - BuildTableView

-(void)buildTableView
{
    UITableView *customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height - 64) style:UITableViewStylePlain];
    customTableView.dataSource = self;
    customTableView.delegate = self;
    [self.view addSubview:customTableView];
}

#pragma mark - TableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
    
}
#pragma mark - TableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            id<ALiTradePage> page = [ALiTradePageFactory itemDetailPage:@"41576306115"];
            id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
            ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
            showParams.openType = ALiOpenTypeAuto;
            [service
             show:showParams.isNeedPush ? self.navigationController : self
             page:page
             showParams:showParams
             taoKeParams:nil
             trackParam:[self trackParams]
             tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
                 
             } tradeProcessFailedCallback:^(NSError * _Nullable error) {
                 
             }];
        }
            break;
        case 1:
        {
            id<ALiTradePage> page = [ALiTradePageFactory shopPage:@"60552065"];
            id<ALiTradeService> service = [ALiTradeSDK sharedInstance].tradeService;
            ALiTradeShowParams *showParams = [[ALiTradeShowParams alloc] init];
            showParams.openType = ALiOpenTypeAuto;
            [service
             show:showParams.isNeedPush ? self.navigationController : self
             page:page
             showParams:showParams
             taoKeParams:nil
             trackParam:[self trackParams]
             tradeProcessSuccessCallback:^(ALiTradeResult * _Nullable result) {
                 
             } tradeProcessFailedCallback:^(NSError * _Nullable error) {
             }];

        }
            break;
            
        default:
            break;
    }
}

- (NSDictionary *)trackParams {
    return @{@"track_key": @"track_value"};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
