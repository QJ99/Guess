//
//  DisPlayScore.h
//  Guess
//
//  Created by QJ on 15/3/9.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DisPlayScore;
@protocol disPlayScoreDelegate<NSObject>
-(void)disPlayScore:(DisPlayScore*)disPlayScore didselectTitle:(NSString*)title;
@end
@interface DisPlayScore : UIView
@property (weak, nonatomic) IBOutlet UILabel *currentScore;
@property (weak, nonatomic) IBOutlet UILabel *heightScore;
@property (weak, nonatomic) id<disPlayScoreDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *repeatButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *mainButton;
+(DisPlayScore *)disPlayScore;
@end
