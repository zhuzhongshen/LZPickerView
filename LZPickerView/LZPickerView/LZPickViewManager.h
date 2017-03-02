//
//  LZPickViewManager.h
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZPickViewManager.h"
#import "LZSiglePickerView.h"
#import "LZDatePicker.h"
#import "LZAreaPickerView.h"
#import "LZAddressPickerView.h"


#import "LZCenterAddressPickerView.h"

@interface LZPickViewManager : NSObject

@property(nonatomic,strong)LZSiglePickerView * singlePicker;

@property(nonatomic,strong)LZDatePicker * datePicker;

/**  LZAreaPickerView 三级联动 **/
@property(nonatomic,strong)LZAreaPickerView * areaPickerView;

@property(nonatomic,strong)LZAddressPickerView * addressPicker;
/** LZCenterAddressPickerView居中的 **/
@property(nonatomic,strong)LZCenterAddressPickerView *centerAddressPickerView;


+ (LZPickViewManager *)sharePickViewManager;

/**  LZSiglePickerView  **/
- (void)showPickViewWithSigleArray:(NSArray *)array compltedBlock:(void(^)(NSString *compltedString))compltedBlock cancelBlock:(void(^)())cancelBlock;
/**  LZDatePicker **/
- (void)showWithDatePickerMode:(UIDatePickerMode)mode compltedBlock:(void(^)(NSDate *compltedDate))compltedBlock cancelBlock:(void(^)())cancelBlock;
/**  LZAreaPickerView 三级联动 **/

- (void)showWithAreaPickerCompltedBlock:(void(^)(NSString * addressString))compltedBlock cancleBlock:(void(^)())cancelBlock;

- (void)showWithAddressPickerCompltedBlock:(void(^)(NSString * addressString))compltedBlock cancleBlock:(void(^)())cancelBlock;

- (void)showWithCenterAddressPickerCompltedBlock:(void(^)(NSString * addressString))compltedBlock cancleBlock:(void(^)())cancelBlock;


@end
