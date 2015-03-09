//
//  DisPlayScore.m
//  Guess
//
//  Created by QJ on 15/3/9.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "DisPlayScore.h"
#import "UIImage+QJ.h"
@implementation DisPlayScore
-(void)awakeFromNib{
    [_repeatButton setBackgroundImage:[UIImage resizedImage:@"FM_btn_jingsai_sel.png"] forState:UIControlStateNormal];
    [_repeatButton setTitle:@"重来" forState:UIControlStateNormal];
    
    [_shareButton setBackgroundImage:[UIImage resizedImage:@"FM_btn_jingsai_sel"] forState:UIControlStateNormal];
    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
    
    
    [_mainButton setBackgroundImage:[UIImage resizedImage:@"FM_btn_jingsai_sel"] forState:UIControlStateNormal];
    [_mainButton setTitle:@"主界面" forState:UIControlStateNormal];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(disPlayScore:didselectTitle:)]) {
        [_delegate disPlayScore:self didselectTitle:[sender titleForState:UIControlStateNormal]];
    }
}
+(DisPlayScore *)disPlayScore{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DisPlayScore" owner:self options:nil];
    return (DisPlayScore *)[nib objectAtIndex:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
