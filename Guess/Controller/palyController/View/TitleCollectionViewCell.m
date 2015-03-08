//
//  TitleCollectionViewCell.m
//  Guess
//
//  Created by qj on 15/3/6.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (void)awakeFromNib {
//    [_showTitle setTextColor:[UIColor blackColor]];
    
    // Initialization code
}
+(TitleCollectionViewCell*)MineHeadView{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TitleCollectionViewCell" owner:self options:nil];
    return [nib objectAtIndex:0];
}

@end
