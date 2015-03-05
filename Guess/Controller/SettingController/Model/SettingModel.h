//
//  SettingModel.h
//  Guess
//
//  Created by qj on 15/3/5.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    arrowsType,
    switchType,
    labelType
} settingType;
typedef void (^modelTodo)();
@interface SettingModel : NSObject
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) settingType setType;
@property (copy, nonatomic) modelTodo modelDo;
@end
