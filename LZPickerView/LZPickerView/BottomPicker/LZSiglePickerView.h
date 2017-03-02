//
//  LZSiglePickerView.h
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZSiglePickerView : UIPickerView
/**
 *   showWithSigleArray
 *
 *   @param compltedBlock  确定按钮回掉
 *   @param cancelBlock    取消按钮回掉
 */
- (void)showWithSigleArray:(NSArray *)array compltedBlock:(void(^)(NSString *compltedString))compltedBlock cancelBlock:(void(^)())cancelBlock;


@end
