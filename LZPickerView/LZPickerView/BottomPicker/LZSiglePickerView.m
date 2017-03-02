//
//  LZSiglePickerView.m
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import "LZSiglePickerView.h"
#import "LZToolbar.h"

@interface LZSiglePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
/**  数据源   **/
@property(nonatomic,strong)NSMutableArray * dataArray;
/**  容器 **/
@property(nonatomic,strong)UIView * containerView;
/**  背景蒙版 **/
@property(nonatomic,strong)UIView * maskView;
/**  toolBar **/
@property(nonatomic,strong)LZToolbar * toolBar;
/**  选中的row **/
@property (nonatomic,assign)NSInteger selectRow;

@end
@implementation LZSiglePickerView

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
  
    }
    return self;
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
- (void)showWithSigleArray:(NSArray *)array compltedBlock:(void (^)(NSString *))compltedBlock cancelBlock:(void (^)())cancelBlock{
    
    //默认为0
    self.selectRow = 0;
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [self reloadAllComponents];
    [self showWithAnimation];
    
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
            compltedBlock(array[weakSelf.selectRow]);
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectRow = row;
    NSLog(@"didSelectRow===%ld",(long)row);
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


#pragma mark lazy

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
