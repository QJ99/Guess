//
//  SettingViewController.m
//  Guess
//
//  Created by qj on 15/3/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingModel.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"设置";
    SettingModel *model1 = [[SettingModel alloc]init];
    model1.title = @"游戏音效";
    model1.setType = switchType;
    
    SettingModel *model2 = [[SettingModel alloc]init];
    model2.title = @"关于看图猜成语";
    model2.setType = arrowsType;
    
    SettingModel *model3 = [[SettingModel alloc]init];
    model3.title = @"意见反馈";
    model3.setType = arrowsType;
    
    SettingModel *model4 = [[SettingModel alloc]init];
    model4.title = @"当前版本号";
    model4.setType = arrowsType;
    _dataSource = [NSMutableArray arrayWithObjects:@[model1],@[model2,model3,model4], nil];
}
#pragma mark -tableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource[section]count];
}
#pragma mark -tableviewdelegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    SettingModel *model = _dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
