//
//  CompetitionControllerView.m
//  Guess
//
//  Created by qj on 15/3/8.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "CompetitionControllerView.h"

@interface CompetitionControllerView ()
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UIImageView *GuessImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *_myCollectionView;
@property (assign, nonatomic) NSInteger time;
@property (strong, nonatomic) NSTimer *seceduTime;
@end

@implementation CompetitionControllerView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _time = 0;
    if (!_seceduTime) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(takeTime) userInfo:nil repeats:YES];
        _seceduTime = timer;
 
    }
}
-(void)dealloc{
    _seceduTime  = nil;
}
-(void)takeTime{
    if ([[_totalTime text]intValue]==[_lastTimeLb.text intValue]) {
        [_seceduTime invalidate];
    }else{
        [_lastTimeLb setText:[NSString stringWithFormat:@"%ld",(long)++_time]];

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
