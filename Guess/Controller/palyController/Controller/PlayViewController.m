//
//  PlayViewController.m
//  Guess
//
//  Created by qj on 15/3/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "PlayViewController.h"
#import "UIImage+QJ.h"
#import "TitleCollectionViewCell.h"
#import "playModel.h"
#import "winAlterView.h"
static NSString * CellIdentifier = @"Cell";
@interface PlayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *guessTitle1;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle2;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle3;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle4;
@property (weak, nonatomic) IBOutlet UIButton *removeErrorButton;
@property (weak, nonatomic) winAlterView *winAlterview;
@property (weak, nonatomic) IBOutlet UIButton *noticeButton;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *guessImage;
@property (strong,nonatomic) NSMutableArray *datasource;
@property (strong,nonatomic) NSMutableArray *guessButtonArrayM;
@property (strong,nonatomic) NSMutableArray *modelArrayM;
@property (assign,nonatomic) NSInteger currentIndex;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *sourceLabel;
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _currentIndex = 1;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView = titleLabel;
    [titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:[NSString stringWithFormat:@"%ld",(long)_currentIndex]];
    _titleLabel = titleLabel;
    
    UIImageView *scoreImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    [scoreImage setImage:[UIImage imageNamed:@"btn_gold.png"]];
    UILabel *scoreLb = [[UILabel alloc]initWithFrame:CGRectMake(scoreImage.frame.size.width-50, 0, 50, 30)];
    _sourceLabel = scoreLb;
    [scoreImage addSubview:scoreLb];
    [scoreLb setTextColor:[UIColor whiteColor]];
    [scoreLb setFont:[UIFont systemFontOfSize:15.0f]];
    [scoreLb setTextAlignment:NSTextAlignmentCenter];
    [scoreLb setText:[NSString stringWithFormat:@"%ld",(_currentIndex-1)*100]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:scoreImage];
    _guessButtonArrayM = [NSMutableArray arrayWithObjects:_guessTitle1,_guessTitle2,_guessTitle3,_guessTitle4 ,nil];
    [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton*)obj;
        [button setBackgroundImage:[UIImage imageNamed:@"answer.png"] forState:UIControlStateNormal];
    }];
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
    [_guessImage setImage:[UIImage imageNamed:model.picName]];
    [_datasource addObjectsFromArray:model.textArray];
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
    [_removeErrorButton setBackgroundImage:[UIImage resizedImage:@"cydg_goumai"] forState:UIControlStateNormal];
    [_noticeButton setBackgroundImage:[UIImage resizedImage:@"cydg_goumai"] forState:UIControlStateNormal];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"TitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    [_myCollectionView setBackgroundColor:[UIColor clearColor]];

}
#pragma mark -guessButtonClick
- (IBAction)guessButtonClick:(UIButton *)sender {
    if ([sender titleForState:UIControlStateNormal]) {
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
}

#pragma mark -返回手势
-(void)tapBackButton:(UITapGestureRecognizer*)tap{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)helpButton:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    if (sender.tag == 0) {//提示答案
        playModel *mode = _modelArrayM[_currentIndex-1];
        [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton *button = (UIButton*)obj;
            [button setTitle:nil forState:UIControlStateNormal];
        }];
        for (int i =0; i<[mode.reslut length]; i++) {
            [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *button = (UIButton*)obj;
                if (![[button titleForState:UIControlStateNormal]length]) {
                    [button setTitle:[mode.reslut substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateNormal];
                    *stop = YES;
                }
                if (idx == _guessButtonArrayM.count-1) {
                    __block NSMutableString *selectext = [[NSMutableString alloc]init];
                    [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        UIButton *guessButton = (UIButton*)obj;
                        selectext = (NSMutableString*)[selectext stringByAppendingString:[guessButton titleForState:UIControlStateNormal]];
                        
                    }];
                    playModel *model = _modelArrayM[_currentIndex-1];
                    if ([selectext isEqualToString:model.reslut]) {
                        winAlterView *win = [winAlterView winAlterView];
                        _winAlterview = win;
                        [win setDelegate:(id<winAlterViewDelegate>)self];
                        [self.view addSubview:win];
                        win.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height+win.frame.size.height*0.5);
                        [UIView animateWithDuration:0.3 animations:^{
                            win.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5);
                        }];
                        playModel *model = _modelArrayM[_currentIndex-1];
                        win.resultTitle.text = model.reslut;
                        [win.descriptImage setImage:[UIImage imageNamed:model.picName]];
                        win.descriptionText.text = model.textSource;
                        
                    }
                }
                
            }];
        }
    }else{//去除错误文字
        playModel *mode = _modelArrayM[_currentIndex-1];
        [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton *button = (UIButton*)obj;
            if ([[button titleForState:UIControlStateNormal]length]) {
                if (![[mode.reslut substringWithRange:NSMakeRange(idx, 1)]isEqualToString:[button titleForState:UIControlStateNormal]]) {
                    [button setTitle:nil forState:UIControlStateNormal];
                }
            }
        }];
        
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
        if (idx == _guessButtonArrayM.count-1) {
           __block NSMutableString *selectext = [[NSMutableString alloc]init];
            [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *guessButton = (UIButton*)obj;
                selectext = (NSMutableString*)[selectext stringByAppendingString:[guessButton titleForState:UIControlStateNormal]];
            
            }];
            playModel *model = _modelArrayM[_currentIndex-1];
            if ([selectext isEqualToString:model.reslut]) {
                winAlterView *win = [winAlterView winAlterView];
                _winAlterview = win;
                [win setDelegate:(id<winAlterViewDelegate>)self];
                [self.view addSubview:win];
                win.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height+win.frame.size.height*0.5);
                [UIView animateWithDuration:0.3 animations:^{
                    win.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5);
                }];
                playModel *model = _modelArrayM[_currentIndex-1];
                win.resultTitle.text = model.reslut;
                [win.descriptImage setImage:[UIImage imageNamed:model.picName]];
                win.descriptionText.text = model.textSource;
                
            }else{
                [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    UIButton *guessButton = (UIButton*)obj;
                    [guessButton setTitle:@"" forState:UIControlStateNormal];

                }];
                UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的答案不正确呦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
            }
        }
    }];
}
-(void)winAlterview:(winAlterView*)alterview didselectTitle:(NSString*)title{
    if ([title isEqualToString:@"主界面"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([title isEqualToString:@"下一题"]){
        _currentIndex = _currentIndex+1;
        playModel *model = _modelArrayM[_currentIndex-1];
        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.textArray];
        [_myCollectionView reloadData];
        [_sourceLabel setText:[NSString stringWithFormat:@"%ld",(_currentIndex-1)*100]];
        [_titleLabel setText:[NSString stringWithFormat:@"%ld",(long)_currentIndex]];
        [_guessImage setImage:[UIImage imageNamed:model.picName]];
        [UIView animateWithDuration:0.3 animations:^{
            _winAlterview.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height+_winAlterview.frame.size.height*0.5);
        }completion:^(BOOL finished) {
            [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *guessButton = (UIButton*)obj;
                [guessButton setTitle:@"" forState:UIControlStateNormal];
                
            }];
        }];
        
    }else if ([title isEqualToString:@"分享"]){
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要分享" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        _currentIndex = _currentIndex+1;
        playModel *model = _modelArrayM[_currentIndex-1];
        [_datasource removeAllObjects];
        [_datasource addObjectsFromArray:model.textArray];
        [_myCollectionView reloadData];
        [_sourceLabel setText:[NSString stringWithFormat:@"%ld",(_currentIndex-1)*100]];
        [_titleLabel setText:[NSString stringWithFormat:@"%ld",(long)_currentIndex]];
        [_guessImage setImage:[UIImage imageNamed:model.picName]];
        [UIView animateWithDuration:0.3 animations:^{
            _winAlterview.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height+_winAlterview.frame.size.height*0.5);
        }completion:^(BOOL finished) {
            [_guessButtonArrayM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *guessButton = (UIButton*)obj;
                [guessButton setTitle:@"" forState:UIControlStateNormal];
                
            }];
        }];
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
