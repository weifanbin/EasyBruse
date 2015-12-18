//
//  SelectViewController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/7.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "SelectViewController.h"
#import "SQLBaseManager.h"
#import "ZZPlaceholderTextView.h"
#import "HSDatePickerViewController.h"

@interface SelectViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,HSDatePickerViewControllerDelegate>
@property (nonatomic ,retain) NSArray *typeArr;
@property (nonatomic ,retain) NSMutableArray *tagArr;
@property (nonatomic ,retain) UIButton *typeBtn;

@property (nonatomic ,retain) UIButton *tagBtn;
@property (nonatomic ,retain) EBTags *selectTag;

@property (nonatomic ,retain) ZZPlaceholderTextView *noteTextView;
@property (nonatomic ,retain) UIButton *selectBtn;
@property (nonatomic ,retain) UIButton *clearBtn;
@property (nonatomic ,retain) UIButton *beginBtn;
@property (nonatomic ,retain) UIButton *endBtn;

@property (nonatomic, strong) UIPickerView *pickerview;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) UIButton *selectViewBtn;
@property (nonatomic, strong) UIButton*cancelBtn;
@property (nonatomic, strong) UIButton*okBtn;

@property (nonatomic) BOOL isShowTagSelect;  // 是否显示类型列表
@property (nonatomic) BOOL isEndDataSelect;  // 是否显示类型列表

@property (nonatomic,retain) NSDate *beginTime;     // 开始时间
@property (nonatomic,retain) NSDate *endTime;       // 结束时间
@end

@implementation SelectViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        //
        self.typeArr = @[@"不限",@"支出",@"收入"];
        self.tagArr = [SQLBaseManager getAllTags];
        EBTags *tag = [EBTags new];
        tag.tname = @"所有标签";
        
        [self.tagArr insertObject:tag atIndex:0];
        
        // 获取当前月的天数
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
        NSUInteger numberOfDaysInMonth = range.length;
        
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:[NSDate date]];
        
        [dateComponents setDay:1];
        self.beginTime = [calendar dateFromComponents:dateComponents];
        
        [dateComponents setDay:numberOfDaysInMonth];
        self.endTime = [calendar dateFromComponents:dateComponents];
        [self initUiView];
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.selectView.frame = CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT);
    self.selectViewBtn.frame = CGRectMake(0, 0, self.selectView.width, self.selectView.height);
    self.cancelBtn.frame = CGRectMake(0, self.selectView.bottom - 35, self.view.width/2.0, 35);
    self.okBtn.frame = CGRectMake(self.view.width/2.0, self.selectView.bottom - 35, self.view.width/2.0, 35);
    self.pickerview.height=162;
    self.pickerview.top = self.selectView.bottom - self.pickerview.height - 35;
    
    [self.beginBtn setTitle:[MV_Utils dateWithDate:self.beginTime withFormat:@"yyyy年MM月dd"]];
    [self.endBtn setTitle:[MV_Utils dateWithDate:self.endTime withFormat:@"yyyy年MM月dd"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    EBViewController *ebv =  (EBViewController *)self.navigationController;
    [ebv.titleBar resetTitle:@"查找"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)titleBarLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUiView
{
    UILabel *typeLab = [UILabel new];
    typeLab.textColor = UIColorFromRGB(0x959595, 1.0);
    typeLab.frame = CGRectMake( 20, NAVIGATION_BAR_HEIGHT + 20, 80, 20);
    typeLab.text = @"类别";
    typeLab.font = font(16);
    [self.view addSubview:typeLab];
    
    self.typeBtn = [UIButton createButton:CGRectMake(typeLab.right + 5, typeLab.top - 10, 150, 40) target:self action:@selector(typeBtnClick)];
    [self.typeBtn setTitle:@"不限" size:16 color:BlackColor Highlighted:BlackColor];
    self.typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //[self.typeBtn setBackgroundColor:[UIColor clearColor] Highlighted:[UIColor clearColor]];
    [self.view addSubview:self.typeBtn];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = UIColorFromRGB(0x959595, 1.0);
    line1.frame = CGRectMake(10, typeLab.bottom + 15, SCREEN_WIDTH - 20, 1);
    [self.view addSubview:line1];
    
    
    UILabel *tagLab = [UILabel new];
    tagLab.textColor = UIColorFromRGB(0x959595, 1.0);
    tagLab.frame = CGRectMake( 20, line1.bottom + 15, 80, 20);
    tagLab.text = @"标签";
    tagLab.font = font(16);
    [self.view addSubview:tagLab];
    
    self.tagBtn = [UIButton createButton:CGRectMake(tagLab.right + 5, tagLab.top - 10, 150, 40) target:self action:@selector(tagBtnClick)];
    [self.tagBtn setTitle:@"所有标签" size:16 color:BlackColor Highlighted:BlackColor];
    self.tagBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //[self.typeBtn setBackgroundColor:[UIColor clearColor] Highlighted:[UIColor clearColor]];
    [self.view addSubview:self.tagBtn];
    
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = UIColorFromRGB(0x959595, 1.0);
    line2.frame = CGRectMake(10, tagLab.bottom + 15, SCREEN_WIDTH - 20, 0.5);
    [self.view addSubview:line2];
    
    UILabel *noteLab = [UILabel new];
    noteLab.textColor = UIColorFromRGB(0x959595, 1.0);
    noteLab.frame = CGRectMake( 20, line2.bottom + 15, 80, 20);
    noteLab.text = @"备注关键字";
    noteLab.font = font(16);
    [self.view addSubview:noteLab];
    
    self.noteTextView = [[ZZPlaceholderTextView alloc] initWithFrame:CGRectMake(noteLab.right, noteLab.top - 7, SCREEN_WIDTH - 80, 40)];
    self.noteTextView.textColor = [UIColor blackColor];
    self.noteTextView.backgroundColor = [UIColor clearColor];
    self.noteTextView.font = font(16);
    self.noteTextView.placeholder = @"请输入备注的关键字";
    [self.view addSubview:self.noteTextView];
    
    UIView *line3 = [UIView new];
    line3.backgroundColor = UIColorFromRGB(0x959595, 1.0);
    line3.frame = CGRectMake(10, noteLab.bottom + 15, SCREEN_WIDTH - 20, 0.5);
    [self.view addSubview:line3];
    
    
    
    UILabel *beginLab = [UILabel new];
    beginLab.textColor = UIColorFromRGB(0x959595, 1.0);
    beginLab.frame = CGRectMake( 20, line3.bottom + 15, 80, 20);
    beginLab.text = @"起始日期";
    beginLab.font = font(16);
    [self.view addSubview:beginLab];
    
    self.beginBtn = [UIButton createButton:CGRectMake(beginLab.right + 5, beginLab.top - 10, 150, 40) target:self action:@selector(showTimeSelectView:)];
    self.beginBtn.tag = 0;
    [self.beginBtn setTitle:@"起始时间" size:16 color:BlackColor Highlighted:BlackColor];
    self.beginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.beginBtn];
    
    UIView *line4 = [UIView new];
    line4.backgroundColor = UIColorFromRGB(0x959595, 1.0);
    line4.frame = CGRectMake(10, beginLab.bottom + 15, SCREEN_WIDTH - 20, 0.5);
    [self.view addSubview:line4];
    

    
    UILabel *endLab = [UILabel new];
    endLab.textColor = UIColorFromRGB(0x959595, 1.0);
    endLab.frame = CGRectMake( 20, line4.bottom + 15, 80, 20);
    endLab.text = @"结束日期";
    endLab.font = font(16);
    [self.view addSubview:endLab];
    
    self.endBtn = [UIButton createButton:CGRectMake(endLab.right + 5, endLab.top - 10, 150, 40) target:self action:@selector(showTimeSelectView:)];
    self.endBtn.tag = 1;
    [self.endBtn setTitle:@"终止时间" size:16 color:BlackColor Highlighted:BlackColor];
    self.endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.endBtn];
    
    UIView *line5 = [UIView new];
    line5.backgroundColor = UIColorFromRGB(0x959595, 1.0);
    line5.frame = CGRectMake(10, endLab.bottom + 15, SCREEN_WIDTH - 20, 0.5);
    [self.view addSubview:line5];
    
    self.clearBtn = [UIButton createButton:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH / 2 - 1, 50) target:self action:@selector(clearBtnClick)];
    [self.clearBtn setTitle:@"清除条件" size:20 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [self.clearBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [self.view addSubview:self.clearBtn];
    
    self.selectBtn = [UIButton createButton:CGRectMake(SCREEN_WIDTH / 2 + 1, SCREEN_HEIGHT - 50, SCREEN_WIDTH / 2, 50) target:self action:@selector(selectBtnClick)];
    [self.selectBtn setTitle:@"条件查询" size:20 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [self.selectBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [self.view addSubview:self.selectBtn];
    
    [self addPickerView];
    
}

- (void)selectBtnClick
{
    NSString *sqlStr = [NSString stringWithFormat:@"WHERE time BETWEEN '%@' AND '%@'",[MV_Utils dateWithDate:self.beginTime withFormat:@"yyyy-MM-dd 00:00:00"],[MV_Utils dateWithDate:self.endTime withFormat:@"yyyy-MM-dd 23:59:59"]];
    
    if (![[self.typeBtn titleForState:UIControlStateNormal] isEqualToString:@"不限"])
    {
       NSString *typeStr = [[self.typeBtn titleForState:UIControlStateNormal] isEqualToString:@"支出"]?(@" AND type = 0"):(@" AND type = 1");
        sqlStr = [sqlStr stringByAppendingString:typeStr];
    }
    
    if (![[self.tagBtn titleForState:UIControlStateNormal] isEqualToString:@"所有标签"])
    {
        NSString *tagStr = [NSString stringWithFormat:@" AND tid = %d",self.selectTag.tid];
        sqlStr = [sqlStr stringByAppendingString:tagStr];
    }
    
    if (self.noteTextView.text.length > 1)
    {
        NSString *nodeStr = [NSString stringWithFormat:@" AND content = %%%@%%",self.noteTextView.text];
        sqlStr = [sqlStr stringByAppendingString:nodeStr];
    }
    
    NSMutableArray *accountArray = [SQLBaseManager getAccountsBySelect:sqlStr];
    NSMutableArray *arr = [SQLBaseManager getAccountsNum];
    NSMutableArray *accountNumArr = [NSMutableArray new];
    
    for (AccountsNum *aNum in arr)
    {
        for (Accounts *acount in accountArray)
        {
            NSLog(@"两个日期 %@ = %@",aNum.time,[MV_Utils styleDateFrom:acount.time]);
            if ([aNum.time isEqualToString:[MV_Utils styleDateFrom:acount.time]])
            {
                [aNum.accountArr addObject:acount];
            }
        }
    }
    
    for (AccountsNum *aNum in arr)
    {
        if(aNum.accountArr.count != 0)
           [accountNumArr addObject:aNum];
    }
    
    // 传值
//    if ([self.bookDelegate respondsToSelector:@selector(refreshData:)])
//    {
//        [self.bookDelegate refreshData:accountNumArr];
//    }
    
    if (self.rf)
    {
        self.rf(accountNumArr);
    }
    
    // 退出
    [self titleBarLeftClick];
}

- (void)clearBtnClick
{
    NSMutableArray *accountArray = [SQLBaseManager getAccountsByYear:[MV_Utils getYear]];
    // 传值
//    if ([self.bookDelegate respondsToSelector:@selector(refreshData:)])
//    {
//        [self.bookDelegate refreshData:accountArray];
//    }
    // 退出
    
    if (self.rf)
    {
        self.rf(accountArray);
    }
    [self titleBarLeftClick];
}

#pragma mark ---pickview
-(void)addPickerView
{
    self.selectView = [[UIView alloc]init];
    self.selectView.backgroundColor = RGBA(0, 0, 0,0.5);
    self.selectView.hidden = YES;
    [self.view addSubview:self.selectView];
    
    self.selectViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectViewBtn addTarget:self action:@selector(cancelBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.selectView addSubview:self.selectViewBtn];
    
    self.pickerview = [[UIPickerView alloc]init];
    self.pickerview.backgroundColor = RGB(210, 210, 210);
    self.pickerview.delegate = self;
    self.pickerview.dataSource = self;
    self.pickerview.showsSelectionIndicator = YES;
    self.pickerview.width = SCREEN_WIDTH;
    [self.selectView addSubview:self.pickerview];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:RGB(52, 110, 200) forState:UIControlStateNormal];
    [self.cancelBtn setBackgroundColor:RGB(229, 229, 229)];
    [self.selectView addSubview:self.cancelBtn];
    
    
    self.okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.okBtn addTarget:self action:@selector(okBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:RGB(229, 229, 229) forState:UIControlStateNormal];
    [self.okBtn setBackgroundColor:RGB(52, 110, 200)];
    [self.selectView addSubview:self.okBtn];
    
}

- (void)showTimeSelectView:(UIButton *)button
{
    HSDatePickerViewController *hsdpvc = [[HSDatePickerViewController alloc] init];
    self.isEndDataSelect = button.tag;
    
    if (self.isEndDataSelect)
    {
        hsdpvc.date = self.endTime;
    }
    else
    {
        hsdpvc.date = self.beginTime;
    }
    hsdpvc.delegate = self;
    hsdpvc.mainColor = GreenColor;
    [self presentViewController:hsdpvc animated:YES completion:nil];

}

- (void)tagBtnClick
{
    self.isShowTagSelect = YES;
    [self.pickerview reloadAllComponents];
    self.selectView.hidden = NO;
    [self.pickerview selectRow:0 inComponent:0 animated:NO];
}

- (void)typeBtnClick
{
    self.selectView.hidden = NO;
    [self.pickerview selectRow:0 inComponent:0 animated:NO];
}

- (void)okBtnTapped
{
    
    self.selectView.hidden = YES;
    
    NSInteger row = [self.pickerview selectedRowInComponent:0];
    if (self.isShowTagSelect)
    {
        EBTags *tag = [self.tagArr objectAtIndex:row];
        [self.tagBtn setTitle:tag.tname];
    }
    else
    {
        [self.typeBtn setTitle:[self.typeArr objectAtIndex:row]];
    }
    self.isShowTagSelect = NO;
}

- (void)cancelBtnTapped
{
    self.isShowTagSelect = NO;
    self.selectView.hidden = YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.isShowTagSelect)
    {
       return self.tagArr.count;
    }
    else
    {
       return self.typeArr.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (self.isShowTagSelect)
    {
        EBTags *tag = [self.tagArr objectAtIndex:row];
        self.selectTag = tag;
        return tag.tname;
    }
    else
    {
        return [self.typeArr objectAtIndex:row];
    }
}

#pragma mark - HSDatePickerViewControllerDelegate
- (void)hsDatePickerPickedDate:(NSDate *)date
{
    NSLog(@"Date picked %@", date);
    if (self.isEndDataSelect)
    {
        self.endTime = date;
        [self.endBtn setTitle:[MV_Utils dateWithDate:self.endTime withFormat:@"yyyy年MM月dd"]];
    }
    else
    {
        self.beginTime = date;
        [self.beginBtn setTitle:[MV_Utils dateWithDate:self.beginTime withFormat:@"yyyy年MM月dd"]];
    }
}

@end
