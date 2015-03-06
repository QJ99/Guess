//
//  PlayViewController.m
//  Guess
//
//  Created by qj on 15/3/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "PlayViewController.h"
#import "UIImage+QJ.h"
@interface PlayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *guessTitle1;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle2;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle3;
@property (weak, nonatomic) IBOutlet UIButton *guessTitle4;
@property (weak, nonatomic) IBOutlet UIButton *removeErrorButton;

@property (weak, nonatomic) IBOutlet UIButton *noticeButton;
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
    
    
}
#pragma mark -guessButtonClick
- (IBAction)guessButtonClick:(UIButton *)sender {
}

#pragma mark -返回手势
-(void)tapBackButton:(UITapGestureRecognizer*)tap{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)helpButton:(UIButton *)sender {
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
