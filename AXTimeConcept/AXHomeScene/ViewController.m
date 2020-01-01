//
//  ViewController.m
//  AXTimeConcept
//
//  Created by lmm on 2020/1/1.
//  Copyright © 2020 xiaoming. All rights reserved.
//

#import "ViewController.h"
#import "AXHomeCell.h"
#import "AXHomeModel.h"
#import "AXHomeHeaderView.h"

NSString *const kAXHomeCellReuseStr = @"kAXHomeCellReuseStr";
NSString *const kAXHomeHeaderViewReuseStr = @"kAXHomeHeaderViewReuseStr";
NSString *const kAXHomeTotalKey = @"totalKey";
NSString *const kAXHomeTime = @"time";
NSString *const kAXHomeDes = @"des";


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSArray *headerTitles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addTime];
    // {"totalKey": ["1111111", "2222222"]}
    // {"11111111":{"time":1111111, "des": "sdflksjlf"}}
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AXHomeHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:kAXHomeHeaderViewReuseStr];
    NSString *file = [[NSBundle mainBundle] pathForResource:@"shiju" ofType:@"plist"];
    self.headerTitles = [NSArray arrayWithContentsOfFile:file];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AXHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kAXHomeCellReuseStr];
    [cell loadInfo:self.dataArr[indexPath.section]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AXHomeHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAXHomeHeaderViewReuseStr];
    
    int num = arc4random() % self.headerTitles.count;
    
    [view loadInfo:self.headerTitles[num]];
    return view;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeTimeWith:self.dataArr[indexPath.section]];
        [self reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - user action

- (IBAction)addAction:(id)sender
{
    [self addTime];
}


#pragma mark - private methods

- (void)reloadData
{
    NSMutableArray *arr = [NSMutableArray array];
     NSArray *keys = [[NSUserDefaults standardUserDefaults] objectForKey:kAXHomeTotalKey];
     for (NSString *str in keys) {
         NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:str];
         AXHomeModel *model = [[AXHomeModel alloc] initWithDic:dic];
         [arr addObject:model];
     }
     self.dataArr = arr;
     [self.tableView reloadData];
}

- (void)addTime
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加时间点" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入时间例如19920201";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入描述信息";
    }];
    
    UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *tfs = [alert textFields];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        // 获取值
        for (UITextField *tf in tfs) {
            if (tf.text.length > 0) {
                dic[kAXHomeTime] = tf.text;
            }
        }
        for (int i = 0; i < tfs.count; i++) {
            UITextField *tf = [tfs objectAtIndex:i];
            if (i == 0) {
                dic[kAXHomeTime] = tf.text;
            }else if (i == 1) {
                dic[kAXHomeDes] = tf.text;
            }
        }
        
        if (dic.count == 2) {
            // 存储
            NSMutableArray *keys = [[[NSUserDefaults standardUserDefaults] objectForKey:kAXHomeTotalKey] mutableCopy];
            
            if (![keys isKindOfClass:[NSArray class]]) {
                keys = [NSMutableArray array];
            }
            if (![keys containsObject:dic[kAXHomeTime]]) {
                [keys addObject:dic[kAXHomeTime]];
                [[NSUserDefaults standardUserDefaults] setObject:keys forKey:kAXHomeTotalKey];
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:dic[kAXHomeTime]];
            }
        }
        [self reloadData];
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:certainAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)removeTimeWith:(AXHomeModel *)model
{
    NSMutableArray *arr = [[[NSUserDefaults standardUserDefaults] objectForKey:kAXHomeTotalKey] mutableCopy];
    if ([arr containsObject:model.time]) {
        [arr removeObject:model.time];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kAXHomeTotalKey];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:model.time];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self removeTimeWith:model];
    }
}

@end
