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
#import "CompetitionControllerView.h"
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@property (weak, nonatomic) IBOutlet UIButton *complateButton;
@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_complateButton setTitle:@"闯关模式" forState:UIControlStateNormal];
    [_complateButton setBackgroundImage:[UIImage imageNamed:@"FM_btn_jingsai_sel"] forState:UIControlStateNormal];
//    
//    NSString *str = @"必将是我一生还是我不能够为了它把做人的尊严和做事的原则抛开不能躲开爱情的危机还有没有一点却还要用自己的青春做赌注去涉足点的自尊和原则了的信仰不修边幅的自己怎么那么可怜呢历史斗争的结果是不断达成新的统一唯物主义和辩证唯物主义是唯物主义的两个组成部分也没有谁有那么好的闲情逸";
//    NSMutableArray *arrayM = [NSMutableArray array];
//    NSString *titel;
//    for (int i =0; i<[str length]; i++) {
//        titel = [str substringWithRange:NSMakeRange(i, 1)];
//        [arrayM addObject:titel];
//    }
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *allPath = [path stringByAppendingPathComponent:@"source.plist"];
//    NSMutableArray *array = [NSMutableArray array];
//    
//    for (int i =1; i<40; i++) {
////        NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[@"",@"",@""] forKeys:@[@"question",@"result",@"description"]];
////        NSDictionary *dict = @{@"question":@"",
////                               @"reslut":@"",
////                               @"description":@""};
//        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: @{@"question":@"",
//                                                                                     @"reslut":@"",
//                                                                                     @"description":@"",
//                                                                                     @"text":@""}];
//        [dict setValue:[NSString stringWithFormat:@"question%d",i] forKey:@"question"];
//        NSMutableString *title = [[NSMutableString alloc]init];
//        for(int i =0;i<24;i++){
//            title = [title stringByAppendingString:arrayM[arc4random()%[arrayM count]]];
//            
//        }
//        [dict setValue:[NSString stringWithFormat:@"%@",title] forKey:@"text"];
//        [array addObject:dict];
//    }
//    [array writeToFile:allPath atomically:YES];
    
    
    
    
    BOOL selected =[[NSUserDefaults standardUserDefaults]boolForKey:@"voice"];
    _voiceButton.selected = selected;
    [_voiceButton setImage:[UIImage imageNamed:@"btn_voice_off"] forState:UIControlStateSelected];
    [_voiceButton setImage:[UIImage imageNamed:@"btn_voice_on"] forState:UIControlStateNormal];
}
- (IBAction)startGuess:(UITapGestureRecognizer *)sender {
    PlayViewController *play = [[PlayViewController alloc]init];
    [self.navigationController pushViewController:play animated:YES];
}
- (IBAction)startCompetition:(UIButton *)sender {
    CompetitionControllerView *competition = [[CompetitionControllerView alloc]init];
    [self.navigationController pushViewController:competition animated:YES];
    
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
