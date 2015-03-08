//
//  winAlterView.m
//  Guess
//
//  Created by qj on 15/3/8.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "winAlterView.h"
#import "UIImage+QJ.h"

@implementation winAlterView
-(void)awakeFromNib{
    [_nextButton setBackgroundImage:[UIImage resizedImage:@"FM_btn_jingsai_sel.png"] forState:UIControlStateNormal];
    [_nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    
    [_shareButton setBackgroundImage:[UIImage resizedImage:@"FM_btn_jingsai_sel"] forState:UIControlStateNormal];
    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
    
    
    [_backMain setBackgroundImage:[UIImage resizedImage:@"FM_btn_jingsai_sel"] forState:UIControlStateNormal];
    [_backMain setTitle:@"主界面" forState:UIControlStateNormal];
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(winAlterview:didselectTitle:)]) {
        [_delegate winAlterview:self didselectTitle:[sender titleForState:UIControlStateNormal]];
    }
}
+(winAlterView *)winAlterView{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"winAlterView" owner:self options:nil];
    return (winAlterView *)[nib objectAtIndex:0];

}
@end
