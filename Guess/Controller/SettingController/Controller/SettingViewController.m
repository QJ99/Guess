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
    model2.modelDo = ^(){
        [self notice:@"看图猜成语是一款全中文益智休闲游戏， 你可以和好友一起体验中国特色文化---成语的魅力"];
    };
    
    SettingModel *model3 = [[SettingModel alloc]init];
    model3.title = @"意见反馈";
    model3.setType = arrowsType;
    model3.modelDo = ^(){
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入你的意见" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alter.alertViewStyle =UIAlertViewStylePlainTextInput;
        [alter show];
        
    };
    
    SettingModel *model4 = [[SettingModel alloc]init];
    model4.title = @"当前版本号";
    model4.modelDo = ^(){
    [self notice:@"当前为最新版本"];
    };
    
    model4.setType = arrowsType;
    _dataSource = [NSMutableArray arrayWithObjects:@[model1],@[model2,model4,model3], nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"common_back.png"] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 40, 44);
    [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = rightItem;
}
#pragma mark -提示
-(void)notice:(NSString*)noticeTitle{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:noticeTitle delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alter show];
}
#pragma mark -返回按钮点击
-(void)backClick:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SettingModel *model = _dataSource[indexPath.section][indexPath.row];
    if(model.setType == switchType){
        UISwitch *switchImage = [[UISwitch alloc]initWithFrame:CGRectMake(0,0, 40, 44)];
        [switchImage addTarget:self action:@selector(turnSwitch:) forControlEvents:UIControlEventValueChanged];
        if ([_customerPlay isPlaying]) {
            switchImage.on = YES;
        }else{
            switchImage.on = NO;
        }
        cell.accessoryView = switchImage;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = model.title;
    return cell;
}
#pragma mark 
-(void)turnSwitch:(UISwitch*)sw{
    if (_customerPlay.isPlaying) {
        [_customerPlay pause];
        sw.on = NO;
    }else{
        [_customerPlay play];
        sw.on = YES;
    }
    if ([_delegate respondsToSelector:@selector(settingControler:isPlay:)]) {
        [_delegate settingControler:self isPlay:sw.on];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingModel *model = _dataSource[indexPath.section][indexPath.row];
    if (model.modelDo) {
        model.modelDo();
    }
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
