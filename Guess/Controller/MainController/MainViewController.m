//
//  MainViewController.m
//  Guess
//
//  Created by QJ on 15/3/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "MainViewController.h"
#import "PlayViewController.h"
#import "SettingViewController.h"
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BOOL selected =[[NSUserDefaults standardUserDefaults]boolForKey:@"voice"];
    _voiceButton.selected = selected;
    [_voiceButton setImage:[UIImage imageNamed:@"btn_voice_off"] forState:UIControlStateSelected];
    [_voiceButton setImage:[UIImage imageNamed:@"btn_voice_on"] forState:UIControlStateNormal];
}
- (IBAction)startGuess:(UITapGestureRecognizer *)sender {
    PlayViewController *play = [[PlayViewController alloc]init];
    [self.navigationController pushViewController:play animated:YES];
}
- (IBAction)setVoice:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults]setBool:!sender.selected forKey:@"voice"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    sender.selected = !sender.selected;
    [sender setImage:[UIImage imageNamed:@"btn_voice_off"] forState:UIControlStateSelected];
    [sender setImage:[UIImage imageNamed:@"btn_voice_on"] forState:UIControlStateNormal];
}
- (IBAction)settingApp:(id)sender {
    SettingViewController *setting = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
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
