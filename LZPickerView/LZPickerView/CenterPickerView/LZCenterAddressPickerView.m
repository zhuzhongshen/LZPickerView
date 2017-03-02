

//
//  LZCenterAddressPickerView.m
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import "LZCenterAddressPickerView.h"
#import "LZPickerViewDefine.h"
@interface LZCenterAddressPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSInteger _provinceIndex;   // 省份选择 记录
    NSInteger _cityIndex;       // 市选择 记录
    NSInteger _districtIndex;   // 区选择 记录
}
/**  容器 **/
@property(nonatomic,strong)UIView * containerView;
/**  背景蒙版 **/
@property(nonatomic,strong)UIView * maskView;
/**  选中的row **/
@property (nonatomic,assign)NSInteger selectRow;

@property(nonatomic,copy)NSString * seletedString;
//数据源
@property(nonatomic,strong)NSArray * arrayDS;

//提示uiview
@property(nonatomic,strong)UIView * topView;

//提示label
@property(nonatomic,strong)UILabel * titleLabel;
//按钮
@property(nonatomic,strong)UIView * bottomView;
@property (nonatomic,assign)CGFloat  alertViewWidth , alertViewHeight , titleHeight , buttonHeight;;


@end
@implementation LZCenterAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    self.titleHeight = 44.0f;
    self.buttonHeight = 44.0f;
    self.alertViewWidth = 280.0f;
    
    
    self.alertViewHeight = 216+self.titleHeight+self.buttonHeight;
    
    
    [self initMaskView];
    
    frame = CGRectMake(0,  self.titleHeight ,  self.alertViewWidth, 216);
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定                                                                                                                           义高度了，一般默认是无法修改其216像素的高度
        self.showsSelectionIndicator = YES;    //这个最好写 你不写来试下哇
        
        _provinceIndex = _cityIndex = _districtIndex = 0;
        
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self initContainerView];
        
        [self initWithTopView];
        
        [self initWithBottomView];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Province" ofType:@"plist"];
        self.arrayDS = [[NSArray alloc] initWithContentsOfFile:path];
        // 默认Picker状态
        [self resetPickerSelectRow];
        
    }
    return self;
}
-(void)resetPickerSelectRow
{
    [self selectRow:_provinceIndex inComponent:0 animated:YES];
    
}



- (void)initMaskView{
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kISCREEN_HEIGHT)];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.maskView.userInteractionEnabled = YES;
    
}

- (void)initContainerView{
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH-self.alertViewWidth)/2.0, (kISCREEN_HEIGHT- self.alertViewHeight)/2.0 , self.alertViewWidth, self.alertViewHeight)];
    
}
- (void)initWithTopView{
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.alertViewWidth, self.titleHeight)];
    self.topView.backgroundColor = [UIColor blackColor];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:self.topView.bounds];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"请选择省市区";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:self.titleLabel];
    
}

- (void)initWithBottomView{
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.alertViewHeight-self.buttonHeight, self.alertViewWidth, self.buttonHeight)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    NSArray * array = [NSArray arrayWithObjects:@"取消",@"确定", nil];
    
    for (int  i =0; i < array.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
        if (i==0) {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        btn.tag = 10000+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.frame = CGRectMake(i * self.alertViewWidth/2.0 , 0,  self.alertViewWidth/2.0, self.bottomView.bounds.size.height);
        [btn addTarget:self action:@selector(isClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:btn];
    }
    UIView * lineOneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  self.alertViewWidth, 1)];
    lineOneView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottomView addSubview:lineOneView];
    
    UIView * lineTwoView = [[UIView alloc]initWithFrame:CGRectMake(self.alertViewWidth/2.0, 0, 1, self.buttonHeight)];
    lineTwoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottomView addSubview:lineTwoView];
    
    
}
- (void)isClick:(UIButton * )sender{
    
    switch (sender.tag) {
        case 10000:{
            if (self.ClickCancelHandle) {
                self.ClickCancelHandle();
                [self hiddenWithAnimation];
            }
        }
            
            break;
        case 10001:{
            
            if (self.ClickCompltedHandle) {
                self.ClickCompltedHandle([self seletedStr]);
                [self hiddenWithAnimation];
            }
        }
            break;
            
        default:
            break;
    }
    
    
    
}
#pragma mark - Action
- (void)showCenterAddressPickerCompltedBlock:(void (^)(NSString *))compltedBlock cancelBlock:(void (^)())cancelBlock{
    
    
    self.ClickCancelHandle = cancelBlock;
    
    
    
    self.ClickCompltedHandle = compltedBlock;
    
    [self showWithAnimation];
    
}
- (NSString *)seletedStr{
    // 省市区地址
    NSString * address = [NSString stringWithFormat:@"%@-%@-%@", self.arrayDS[_provinceIndex][@"province"], self.arrayDS[_provinceIndex][@"citys"][_cityIndex][@"city"], self.arrayDS[_provinceIndex][@"citys"][_cityIndex][@"districts"][_districtIndex]];
    return address;
}


- (void)showWithAnimation{
    
    [self addViews];
    
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    CGFloat height = self.containerView.frame.size.height;
    self.containerView.center = CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT + height / 2);
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center =    CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT/2.0);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
}
- (void)hiddenWithAnimation
{
    CGFloat height = self.containerView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT+ height / 2);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self hiddenViews];
    }];
    
}
- (void)addViews{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.containerView];
    //设置圆角边框
    
    self.containerView.layer.cornerRadius = 8;
    
    self.containerView.layer.masksToBounds = YES;
    [self.containerView addSubview:self.topView];
    
    [self.containerView addSubview:self];
    
    [self setFrame:CGRectMake(0, self.topView.bounds.size.height,  self.containerView.bounds.size.width, 216)];
    [self layoutIfNeeded];
    
    
    NSLog(@"addViews===self.frame.size.width=====%lf",self.frame.size.width);
    
    [self.containerView addSubview:self.bottomView];
    
}
- (void)hiddenViews {
    [self removeFromSuperview];
    [self.maskView removeFromSuperview];
    [self.containerView removeFromSuperview];
    [self.topView removeFromSuperview];
    [self.bottomView removeFromSuperview];
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return self.arrayDS.count;
    }
    else if (component == 1){
        return [self.arrayDS[_provinceIndex][@"citys"] count];
    }
    else{
        return [self.arrayDS[_provinceIndex][@"citys"][_cityIndex][@"districts"] count];
    }
}

// 返回每一行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        return self.arrayDS[row][@"province"];
    }
    else if (component == 1){
        return self.arrayDS[_provinceIndex][@"citys"][row][@"city"];
    }
    else{
        return self.arrayDS[_provinceIndex][@"citys"][_cityIndex][@"districts"][row];
    }
}

// 滑动或点击选择，确认pickerView选中结果
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(component == 0){
        _provinceIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        [self reloadComponent:1];
        [self reloadComponent:2];
    }
    else if (component == 1){
        _cityIndex = row;
        _districtIndex = 0;
        
        [self reloadComponent:2];
    }
    else{
        _districtIndex = row;
    }
    
    // 重置当前选中项
    [self resetPickerSelectRow];
}
////  第component列的宽度是多少
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//
//
//
//    return (self.alertViewWidth-80)/3.0;
//
//}


@end
