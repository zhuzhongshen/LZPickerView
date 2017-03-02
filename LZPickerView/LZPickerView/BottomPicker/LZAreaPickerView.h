//
//  LZAreaPickerView.h
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZAreaPickerView : UIPickerView


- (void)showAddressPickerCompltedBlock:(void (^)(NSString *))compltedBlock cancelBlock:(void (^)())cancelBlock;

@end