//
//  SettingViewController.h
//  Guess
//
//  Created by qj on 15/3/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
@class SettingViewController;
@protocol settingControllerDelegate<NSObject>
-(void)settingControler:(SettingViewController*)settingController isPlay:(BOOL)isplay;
@end
@interface SettingViewController : BaseViewController
@property (strong, nonatomic) AVAudioPlayer *customerPlay;
@property (weak, nonatomic) id<settingControllerDelegate>delegate;
@end
