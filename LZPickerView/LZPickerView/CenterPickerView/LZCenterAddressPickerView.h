//
//  LZCenterAddressPickerView.h
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZCenterAddressPickerView : UIPickerView


- (void)showCenterAddressPickerCompltedBlock:(void (^)(NSString *))compltedBlock cancelBlock:(void (^)())cancelBlock;

//取消按钮点击回掉
@property(nonatomic,copy)void (^ClickCancelHandle)();
//确认按钮点击回掉
@property(nonatomic,copy)void (^ClickCompltedHandle)(NSString * compltedStr);


@end
