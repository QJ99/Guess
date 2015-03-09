//
//  CompetitionControllerView.m
//  Guess
//
//  Created by qj on 15/3/8.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "CompetitionControllerView.h"
#import "playModel.h"
#import "TitleCollectionViewCell.h"
#import "DisPlayScore.h"
static NSString * CellIdentifier = @"Cell";
@interface CompetitionControllerView ()
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UIImageView *GuessImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (assign, nonatomic) NSInteger time;
@property (strong, nonatomic) NSTimer *seceduTime;
@property (strong,nonatomic) NSMutableArray *modelArrayM;
@property (strong,nonatomic) NSMutableArray *datasource;
@property (assign,nonatomic) NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UIButton *guessTitle1;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle2;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle3;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle4;
@property (strong,nonatomic) NSMutableArray *guessButtonArrayM;
@property (weak, nonatomic) UILabel *titleLabel;
@property (assign,nonatomic) NSInteger rightCount;
@property (weak, nonatomic) DisPlayScore *displayScore;
@property (assign, nonatomic) int secondCount;
@end

@implementation CompetitionControllerView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
    _rightCount = 0;
    _currentIndex = 1;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView = titleLabel;
    [titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:[NSString stringWithFormat:@"%ld",(long)_currentIndex]];
    _titleLabel = titleLabel;

    UIImageView *bottomView = [[UIImageView alloc]init];
    bottomView.userInteractionEnabled = YES;
    [bottomView setContentMode:UIViewContentModeScaleAspectFit];
    bottomView.bounds = CGRectMake(0, 0, 60, 30);
    [bottomView setImage:[UIImage imageNamed:@"ZJM_btn_fanhui.png"]];
    
    UIImageView *titleView = [[UIImageView alloc]init];
    titleView.userInteractionEnabled = YES;
    [titleView setContentMode:UIViewContentModeScaleAspectFit];
    titleView.frame = CGRectMake(bottomView.frame.size.width-35, 0, 30, 30);
    [bottomView addSubview:titleView];
    [titleView setImage:[UIImage imageNamed:@"ZJM_wz_back.png"]];
    UITapGestureRecognizer *tapBottomView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackButton:)];
    [bottomView addGestureRecognizer:tapBottomView];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:bottomView];
    self.navigationItem.leftBarButtonItem = leftButton;

    _guessButtonArrayM = [NSMutableArray arrayWithObjects:_guessTitle1,_guessTitle2,_guessTitle3,_guessTitle4 ,nil];
    [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton*)obj;
        [button setBackgroundImage:[UIImage imageNamed:@"answer.png"] forState:UIControlStateNormal];
    }];
    _time = 0;
    if (!_seceduTime) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(takeTime) userInfo:nil repeats:YES];
        _seceduTime = timer;
 
    }
    [self loadDataSource];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"TitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    [_myCollectionView setBackgroundColor:[UIColor clearColor]];
}
#pragma mark -返回手势
-(void)tapBackButton:(UITapGestureRecognizer*)tap{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -加载数据资源
-(void)loadDataSource{
    //加载数据资源
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"source.plist" ofType:nil]];
    _modelArrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        playModel *model = [[playModel alloc]init];
        model.reslut = dict[@"reslut"];
        model.textSource = dict[@"description"];
        model.picName = dict[@"question"];
        NSString *text = dict[@"text"];
        NSString *title;
        NSMutableArray *txtArray = [NSMutableArray array];
        for (int i = 0; i<[text length]; i++) {
            title = [text substringWithRange:NSMakeRange(i, 1)];
            [txtArray addObject:title];
            model.textArray = [NSMutableArray arrayWithArray:txtArray];
        }
        [_modelArrayM addObject:model];
    }
    _datasource = [NSMutableArray array];
    playModel *model = _modelArrayM[_currentIndex-1];
    [_GuessImageView setImage:[UIImage imageNamed:model.picName]];
    [_datasource addObjectsFromArray:model.textArray];
}
#pragma mark -guessButtonClick
- (IBAction)guessButtonClick:(UIButton *)sender {
    if ([sender titleForState:UIControlStateNormal]) {
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
}
#pragma mark -collectionviewdelegate
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    playModel *model = _datasource[section];
    return _datasource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleCollectionViewCell *cell=[_myCollectionView dequeueReusableCellWithReuseIdentifier: CellIdentifier forIndexPath:indexPath];
    cell.showTitle.text = _datasource[indexPath.row];
    return cell;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(25,25);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 1, 0 ,1);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleCollectionViewCell *cell = (TitleCollectionViewCell*)[_myCollectionView cellForItemAtIndexPath:indexPath];
    NSString *title = cell.showTitle.text;
    [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *guessButton = (UIButton*)obj;
        if (![[guessButton titleForState:UIControlStateNormal]length]) {
            [guessButton setTitle:title forState:UIControlStateNormal];
            [guessButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            *stop = YES;
        }
        if (idx == _guessButtonArrayM.count-1) {//猜对时间小于预定时间
            __block NSMutableString *selectext = [[NSMutableString alloc]init];
            [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *guessButton = (UIButton*)obj;
                selectext = (NSMutableString*)[selectext stringByAppendingString:[guessButton titleForState:UIControlStateNormal]];
            }];
            playModel *model = _modelArrayM[_currentIndex-1];
            if ([selectext isEqualToString:model.reslut]) {
                _secondCount = 0;
                _currentIndex = _currentIndex+1;
                _rightCount = _rightCount+1;
                playModel *model = _modelArrayM[_currentIndex-1];
                [_datasource removeAllObjects];
                [_datasource addObjectsFromArray:model.textArray];
                [_myCollectionView reloadData];
                [_GuessImageView setImage:[UIImage imageNamed:model.picName]];
                [_titleLabel setText:[NSString stringWithFormat:@"%ld",(long)_currentIndex]];
                [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    UIButton *guessButton = (UIButton*)obj;
                    [guessButton setTitle:nil forState:UIControlStateNormal];
                }];
            }
        }
    }];
}
-(void)dealloc{
    _seceduTime  = nil;
}
-(void)takeTime{
    if ([[_totalTime text]intValue]==[_lastTimeLb.text intValue]) {
        [_seceduTime invalidate];
        _seceduTime = nil;
        DisPlayScore *win = [DisPlayScore disPlayScore];
        _displayScore = win;
        [win setDelegate:(id<disPlayScoreDelegate>)self];
        [self.view addSubview:win];
        win.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height+win.frame.size.height*0.5);
        [UIView animateWithDuration:0.3 animations:^{
            win.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5);
        }];
        win.currentScore.text = [NSString stringWithFormat:@"%ld",_rightCount*100];
        NSString *height = [[NSUserDefaults standardUserDefaults]objectForKey:@"heightScroe"];
        if([height length]){
            if ([height intValue]>_rightCount*100) {
                win.heightScore.text = height;
            }else{
                win.heightScore.text = [NSString stringWithFormat:@"%ld",_rightCount*100];
                [[NSUserDefaults standardUserDefaults]setObject:win.heightScore.text forKey:@"heightScroe"];
            }
        }else{
            win.heightScore.text = [NSString stringWithFormat:@"%ld",_rightCount*100];
            [[NSUserDefaults standardUserDefaults]setObject:win.heightScore.text forKey:@"heightScroe"];
        }
    }else{
        [_lastTimeLb setText:[NSString stringWithFormat:@"%ld",(long)++_time]];
        ++_secondCount;
        if (_secondCount == 15) {
            _secondCount = 0;
            _currentIndex = _currentIndex+1;
            if (_currentIndex <= [_modelArrayM count]-1) {
                playModel *model = _modelArrayM[_currentIndex-1];
                [_datasource removeAllObjects];
                [_datasource addObjectsFromArray:model.textArray];
                [_myCollectionView reloadData];
                [_GuessImageView setImage:[UIImage imageNamed:model.picName]];
                [_titleLabel setText:[NSString stringWithFormat:@"%ld",(long)_currentIndex]];
                [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    UIButton *guessButton = (UIButton*)obj;
                    [guessButton setTitle:nil forState:UIControlStateNormal];
                }];
            }
        }
    }
}
-(void)disPlayScore:(DisPlayScore*)disPlayScore didselectTitle:(NSString*)title{
    if ([title isEqualToString:@"重来"]) {
        _currentIndex = 1;
        _rightCount = 0;
        [self loadDataSource];
        [_titleLabel setText:[NSString stringWithFormat:@"%ld",(long)_currentIndex]];
        [_myCollectionView reloadData];
        
        [UIView animateWithDuration:0.3 animations:^{
            _displayScore.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height+_displayScore.frame.size.height*0.5);
        }completion:^(BOOL finished) {
            [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *guessButton = (UIButton*)obj;
                [guessButton setTitle:@"" forState:UIControlStateNormal];
                
            }];
        }];
        if (!_seceduTime) {
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(takeTime) userInfo:nil repeats:YES];
            _seceduTime = timer;
            _time = 0;
            [_lastTimeLb setText:@"0"];
            
        }else{
            
        }
    }else if ([title isEqualToString:@"分享"]){
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要分享" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
    }else if ([title isEqualToString:@"主界面"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
      
        [UIView animateWithDuration:0.3 animations:^{
             _displayScore.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height+_displayScore.frame.size.height*0.5);
        }];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden{
    return YES;
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
