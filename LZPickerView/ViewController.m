//
//  ViewController.m
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import "ViewController.h"
#import "LZSiglePickerView.h"
#import "LZPickerViewDefine.h"
#import "LZPickViewManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * array = @[@"Sigle PickerView",@"DatePicker",@"Address PickerView",@"Center DatePicker"];
    CGFloat btnWidth = 200.0f;
    CGFloat btnHeight = 44.0f;
    CGFloat btnMargin = 20.0f;
    
    for (int i = 0; i <array.count; i++) {
        
        UIButton * btn = [UIButton  buttonWithType:UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake((kSCREEN_WIDTH-btnWidth)/2.0, 100+i * (btnHeight+btnMargin), btnWidth, btnHeight);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:btn];
        btn.tag = 1000+i;
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(isClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma selector
- (void)isClick:(UIButton *) btn{
    
    
    switch (btn.tag) {
        case 1000:
        {
            [[LZPickViewManager sharePickViewManager]showPickViewWithSigleArray:@[@"王者荣耀花木兰",@"王者荣耀大乔",@"王者荣耀猪八戒",@"王者荣耀黄忠",@"王者荣耀诸葛亮",@"王者荣耀哪吒",@"王者荣耀巨灵神",@"王者荣耀刑天",@"王者荣耀盖聂",@"王者荣耀庞统",@"王者荣耀龙且",@"王者荣耀安禄山",@"王者荣耀太乙真人"] compltedBlock:^(NSString *compltedString) {
                NSLog(@"选择的是:%@",compltedString);
                
                [btn setTitle:compltedString forState:UIControlStateNormal];
                
            } cancelBlock:^{
                NSLog(@"取消回掉");
            }];
            
        }
            break;
        case 1001:{
            [[LZPickViewManager sharePickViewManager]showWithDatePickerMode:UIDatePickerModeDateAndTime compltedBlock:^(NSDate *compltedDate) {
                NSLog(@"选择的日期是:%@",compltedDate);
                [btn setTitle:[NSString stringWithFormat:@"%@",compltedDate] forState:UIControlStateNormal];
            } cancelBlock:^{
                NSLog(@"取消回掉");
            }];
        }
            
            break;
            
        case 1002 :
        {
            
            [[LZPickViewManager sharePickViewManager]showWithAddressPickerCompltedBlock:^(NSString *addressString) {
                
                [btn setTitle:[NSString stringWithFormat:@"%@",addressString] forState:UIControlStateNormal];
            } cancleBlock:^{
                NSLog(@"取消回掉");
            }];
        }
            break;
        case 1003:
        {
            
            [[LZPickViewManager sharePickViewManager]showWithCenterAddressPickerCompltedBlock:^(NSString *addressString) {
                
                [btn setTitle:[NSString stringWithFormat:@"%@",addressString] forState:UIControlStateNormal];
            } cancleBlock:^{
                NSLog(@"取消回掉");
            }];
            
            
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
