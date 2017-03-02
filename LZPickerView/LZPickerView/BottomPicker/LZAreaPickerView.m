

//
//  LZAreaPickerView.m
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import "LZAreaPickerView.h"
#import "LZToolbar.h"

@interface LZAreaPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
/** 省 **/
@property (strong,nonatomic)NSArray *provinceList;
/** 市 **/
@property (strong,nonatomic)NSArray *cityList;
/** 区 **/
@property (strong,nonatomic)NSArray *areaList;
/** 第一级选中的下标 **/
@property (assign, nonatomic)NSInteger selectOneRow;
/** 第二级选中的下标 **/
@property (assign, nonatomic)NSInteger selectTwoRow;
/** 第三级选中的下标 **/
@property (assign, nonatomic)NSInteger selectThreeRow;
/**  容器 **/
@property(nonatomic,strong)UIView * containerView;
/**  背景蒙版 **/
@property(nonatomic,strong)UIView * maskView;
/**  toolBar **/
@property(nonatomic,strong)LZToolbar * toolBar;
/**  选中的row **/
@property (nonatomic,assign)NSInteger selectRow;

@property(nonatomic,copy)NSString * choseAddress;

@end
@implementation LZAreaPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    [self initToolBar];
    [self initMaskView];
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self initContainerView];
        
        
        [self getCityListJSON];//获取数据
        [self getCitydate:0];// 默认显示数据
        [self getAreaDate:0];
        
    }
    return self;
}

/**
 *  读取城市文件
 */
- (void)getCityListJSON{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"city" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSArray *provinceList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.provinceList = provinceList;
    
}
- (void)getCitydate:(NSInteger)row{
    
    
    if ([self.provinceList[row][@"type"] intValue] == 0) {
        NSArray *cityArr = [[NSArray alloc] initWithObjects:self.provinceList[row], nil];
        self.cityList = cityArr;
        
    }else{
        NSMutableArray *cityList = [[NSMutableArray alloc] init];
        for (NSArray *cityArr in self.provinceList[row][@"sub"]) {
            [cityList addObject:cityArr];
        }
        self.cityList = cityList;
    }
    
    
}
- (void)getAreaDate:(NSInteger)row{
    if ([self.provinceList[self.selectOneRow][@"type"] intValue] == 0) {
        NSMutableArray *areaList = [[NSMutableArray alloc] init];
        for (NSArray *cityDict in self.provinceList[self.selectOneRow][@"sub"]) {
            [areaList addObject:cityDict];
        }
        self.areaList = areaList;
    }else{
        
        NSMutableArray *areaList = [[NSMutableArray alloc] init];
        for (NSArray *cityDict in self.cityList[row][@"sub"]) {
            [areaList addObject:cityDict];
        }
        self.areaList = areaList;
    }
    
}


- (void)initToolBar{
    self.toolBar = [[LZToolbar alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 44)];
    self.toolBar.translucent = NO;
}
- (void)initMaskView{
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kISCREEN_HEIGHT)];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.maskView.userInteractionEnabled = YES;
    [ self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithAnimation)]];
}

- (void)initContainerView{
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, kISCREEN_HEIGHT - self.frame.size.height - 44, kSCREEN_WIDTH, self.frame.size.height + self.toolBar.frame.size.height)];
}


#pragma mark - Action
- (void)showAddressPickerCompltedBlock:(void (^)(NSString *addressString))compltedBlock cancelBlock:(void (^)())cancelBlock{
    
    
    [self showWithAnimation];
    
    /*
     //默认为0
     self.selectRow = 0;
     self.dataArray = [NSMutableArray arrayWithArray:array];
     [self reloadAllComponents];
     [self showWithAnimation];
     */
    __weak typeof(self) weakSelf = self;
    //点击取消回掉
    [self.toolBar setCancelBlock:^{
        if (cancelBlock) {
            [weakSelf hiddenWithAnimation];
            cancelBlock();
        }
    }];
    //点击确定提交
    [self.toolBar setCommitBlock:^{
        if (compltedBlock) {
            [weakSelf hiddenWithAnimation];
            compltedBlock(weakSelf.choseAddress);
        }
    }];
    
    
}

- (void)showWithAnimation{
    
    [self addViews];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    CGFloat height = self.containerView.frame.size.height;
    self.containerView.center = CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT + height / 2);
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT - height / 2);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
}
- (void)hiddenWithAnimation
{
    CGFloat height = self.containerView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT + height / 2);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self hiddenViews];
    }];
    
}
- (void)addViews{
    [self removeFromSuperview];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.containerView];
    [self.containerView addSubview:self.toolBar];
    [self.containerView addSubview:self];
    self.frame = CGRectMake(0, 44, kSCREEN_WIDTH, 216);
    
}
- (void)hiddenViews {
    [self removeFromSuperview];
    [self.toolBar removeFromSuperview];
    [self.maskView removeFromSuperview];
    [self.containerView removeFromSuperview];
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.provinceList.count;
    }else if (component == 1){
        return self.cityList.count;
    }else if (component == 2){
        return self.areaList.count;
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    static NSInteger oneRow = 0;
    static NSInteger tweRow = 0;
    static NSInteger threeRow = 0;
    if (component == 0) {
        
        self.selectOneRow = row;
        [self getCitydate:row];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [self getAreaDate:0];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        if ([self.provinceList[self.selectOneRow][@"type"] intValue] == 0) {
            
            self.selectTwoRow = 0;
        }
        oneRow = row;
        tweRow = 0;
        threeRow = 0;
        
    }
    if (component == 1){
        
        self.selectTwoRow = row;
        [self getAreaDate:row];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        tweRow = row;
        threeRow = 0;
    }
    if (component == 2){
        
        self.selectThreeRow = row;
        threeRow = row;
    }
    NSMutableString *regionAddress = [[NSMutableString alloc] init];
    if (oneRow > 0 &&[self.provinceList[self.selectOneRow][@"type"] intValue] != 0 ) {
        [regionAddress appendFormat:@"%@省",self.provinceList[self.selectOneRow][@"name"]];
        
    }
    if (tweRow > 0 || [self.provinceList[self.selectOneRow][@"type"] intValue] == 0){
        
        [regionAddress appendFormat:@"%@市",self.cityList[self.selectTwoRow][@"name"]];
    }
    if (threeRow > 0 ){
        [regionAddress appendFormat:@"%@",self.areaList[self.selectThreeRow][@"name"]];
    }
    NSLog(@"regionAddress===%@",regionAddress);
    
    self.choseAddress = regionAddress;
    
    //  self.address_TF.text = regionAddress;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return self.provinceList[row][@"name"];
        
    }
    if (component == 1){
        if ([self.provinceList[self.selectOneRow][@"type"] intValue] == 0) {
            
            
            return self.cityList[0][@"name"];
        }else {
            
            return self.cityList[row][@"name"];
        }
        
    }
    if (component == 2){
        
        return self.areaList[row][@"name"];
    }
    return nil;
}

- (void)clearSpearatorLine
{
    for (UIView * subView1 in self.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView * subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    subView2.backgroundColor = [UIColor redColor];
                    //subView2.hidden = YES;//隐藏分割线
                }
            }
        }
    }
}



@end
