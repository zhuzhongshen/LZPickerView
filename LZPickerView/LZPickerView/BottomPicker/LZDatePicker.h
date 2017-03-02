//
//  LZDatePicker.h
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZDatePicker : UIDatePicker

/**
 *   showWithSigleArray
 *
 *   @param compltedBlock  确定按钮回掉
 *   @param cancelBlock    取消按钮回掉
 */
- (void)showWithDatePickerMode:(UIDatePickerMode)mode compltedBlock:(void (^)(NSDate *choseDate))compltedBlock cancelBlock:(void (^)())cancelBlock;


@end
