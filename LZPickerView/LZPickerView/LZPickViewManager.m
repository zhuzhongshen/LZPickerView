
//
//  LZPickViewManager.m
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import "LZPickViewManager.h"

static LZPickViewManager * manager = nil;

@implementation LZPickViewManager


+ (LZPickViewManager *)sharePickViewManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LZPickViewManager alloc]init];
    });
    return manager;
}

- (void)showPickViewWithSigleArray:(NSArray *)array compltedBlock:(void(^)(NSString *compltedString))compltedBlock cancelBlock:(void(^)())cancelBlock{
    
    [self.singlePicker showWithSigleArray:array compltedBlock:^(NSString *compltedString) {
        if (compltedBlock) {
            
            compltedBlock(compltedString);
        }
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
    
}

- (void)showWithDatePickerMode:(UIDatePickerMode)mode compltedBlock:(void(^)(NSDate *compltedDate))compltedBlock cancelBlock:(void(^)())cancelBlock{
    
    [self.datePicker showWithDatePickerMode:mode compltedBlock:^(NSDate * choseDate) {
        if (compltedBlock) {
            compltedBlock(choseDate);
        }
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
    
    
}

- (void)showWithAreaPickerCompltedBlock:(void(^)(NSString * addressString))compltedBlock cancleBlock:(void(^)())cancelBlock{
    
    [self.areaPickerView showAddressPickerCompltedBlock:^(NSString *addressString) {
        if (compltedBlock) {
            compltedBlock(addressString);
        }
        
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
}


- (void)showWithAddressPickerCompltedBlock:(void(^)(NSString * addressString))compltedBlock cancleBlock:(void(^)())cancelBlock{
    [self.addressPicker showAddressPickerCompltedBlock:^(NSString *addressString) {
        if (compltedBlock) {
            compltedBlock(addressString);
        }
        
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
}

#pragma margin center
- (void)showWithCenterAddressPickerCompltedBlock:(void(^)(NSString * addressString))compltedBlock cancleBlock:(void(^)())cancelBlock{
    
    [self.centerAddressPickerView showCenterAddressPickerCompltedBlock:^(NSString *addressString) {
        if (compltedBlock) {
            compltedBlock(addressString);
        }
        
    } cancelBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
    
}

#pragma lazy
//单个选择器
- (LZSiglePickerView *)singlePicker
{
    if (!_singlePicker) {
        _singlePicker = [[LZSiglePickerView alloc]init];
    }
    return _singlePicker;
    
}
//日期选择器
- (LZDatePicker *)datePicker
{
    if (!_datePicker) {
        
        _datePicker = [[LZDatePicker alloc]init];
    }
    return _datePicker;
}
- (LZAreaPickerView *)areaPickerView
{
    if (!_areaPickerView) {
        _areaPickerView = [[LZAreaPickerView alloc]init];
    }
    return _areaPickerView;
}
- (LZAddressPickerView *)addressPicker
{
    if (!_addressPicker) {
        _addressPicker = [[LZAddressPickerView alloc]init];
    }
    return _addressPicker;
}


- (LZCenterAddressPickerView *)centerAddressPickerView
{
    if (!_centerAddressPickerView) {
        _centerAddressPickerView = [[LZCenterAddressPickerView alloc]init];
    }
    return _centerAddressPickerView;
}

@end
