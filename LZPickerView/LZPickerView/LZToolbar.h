//
//  LZToolbar.h
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPickerViewDefine.h"


@interface LZToolbar : UIToolbar

@property (nonatomic, strong) UIBarButtonItem *cancelBar;
@property (nonatomic, strong) UIBarButtonItem *commitBar;
@property (nonatomic, strong) UIBarButtonItem *titleBar;

/**取消*/
@property (nonatomic, strong) NSString *cancelBarTitle;

/**[UIColor colorWithRed:0.090  green:0.463  blue:0.906 alpha:1]*/
@property (nonatomic, strong) UIColor *cancelBarTintColor;

/**完成*/
@property (nonatomic, strong) NSString *commitBarTitle;

/**[UIColor colorWithRed:0.090  green:0.463  blue:0.906 alpha:1]*/
@property (nonatomic, strong) UIColor *commitBarTintColor;

/**""*/
@property (nonatomic, strong) NSString *titleBarTitle;

/** [UIColor colorWithRed:0.804  green:0.804  blue:0.804 alpha:1]*/
@property (nonatomic, strong) UIColor *titleBarTextColor;

@property (nonatomic, strong) void (^cancelBlock)();
@property (nonatomic, strong) void (^commitBlock)();

@end
