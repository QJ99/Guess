//
//  winAlterView.h
//  Guess
//
//  Created by qj on 15/3/8.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class winAlterView;
@protocol winAlterViewDelegate<NSObject>
-(void)winAlterview:(winAlterView*)alterview didselectTitle:(NSString*)title;
@end
@interface winAlterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *resultTitle;
@property (weak, nonatomic) IBOutlet UILabel *descriptionText;
@property (weak, nonatomic) IBOutlet UIImageView *descriptImage;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *backMain;
@property (weak, nonatomic) id<winAlterViewDelegate>delegate;
+(winAlterView*)winAlterView;
@end
