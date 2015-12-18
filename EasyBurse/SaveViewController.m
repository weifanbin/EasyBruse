//
//  SaveViewController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "SaveViewController.h"
#import "Accounts.h"
#import "SQLBaseManager.h"
#import "HSDatePickerViewController.h"
#import "HTKSampleCollectionViewCell.h"

@interface SaveViewController ()<HSDatePickerViewControllerDelegate>
{
    UIWindow *__sheetWindow ;//window必须为全局变量或成员变量
}
@property (nonatomic,retain) UIButton *payBtn;
@property (nonatomic,retain) UIButton *incomeBtn;
@property (nonatomic,retain) UITextView *moneyText;
@property (nonatomic,retain) UITextView *contentText;
@property (nonatomic,retain) NSDate *time;
@property (nonatomic,retain) UILabel *dayLabel;
@property (nonatomic,retain) UILabel *timeLabel;
@property (nonatomic,retain) NSMutableArray *tagArray;
@property (nonatomic,retain) EBTags *selectTag;
@property (nonatomic) BOOL isPay;

@end

@implementation SaveViewController
@synthesize payBtn;
@synthesize incomeBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.titleBar resetTitle:@"快记账"];
    
    [self initData];
    
    [self initTopUiView];
    
//    //注册通知,监听键盘弹出事件
//    [[NSNotificationCenter
//      defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//    
//    //注册通知,监听键盘消失事件
//    
//    [[NSNotificationCenter
//      defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:) name:UIKeyboardDidHideNotification object:nil];

}

////键盘弹出时
//-(void)keyboardDidShow:(NSNotification*)notification
//{
//    NSDictionary *userInfo = [notification userInfo];
//    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    [UIView beginAnimations:@"ResizeTextView" context:nil];
//    [UIView setAnimationDuration:0.1f];
//
//    
//    [self.nameText setFrame:CGRectMake(self.nameText.left, self.nameText.top - 80, self.nameText.frame.size.width,self.nameText.frame.size.height)];
//    
//    [UIView commitAnimations];
//}
////键盘消失时
//
//-(void)keyboardDidHidden:(NSNotification*)notification
//{
//    //获取键盘高度
//    NSDictionary *userInfo = [notification userInfo];
//    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    //定义动画
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.1f];
//    
//    [self.nameText setFrame:CGRectMake(self.nameText.left, self.nameText.top + 80, self.nameText.frame.size.width,self.nameText.frame.size.height)]; //键盘消失恢复tableview
//    
//    [UIView commitAnimations];
//    
//}

- (void)initData
{
    self.isPay = YES;
    self.time = [NSDate date];
    self.tagArray = [SQLBaseManager getTagsWithType:self.isPay];
    self.contentText.text = @"";
    self.moneyText.text = @"";
    
    [payBtn setTitle:@"支出" size:15 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [payBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [incomeBtn setTitle:@"收入" size:15 color:RGB(116, 207, 148) Highlighted:WhiteColor];
    [incomeBtn setBackgroundColor:RGB(229, 229, 229) Highlighted:RGB(116, 207, 148)];
}

- (void)initTopUiView
{
    
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    
    self.moneyText = [[UITextView alloc]init];
    self.moneyText.frame = CGRectMake(20, 20, SCREEN_WIDTH - 140, 80);
    self.moneyText.font = font(50);
    self.moneyText.textColor = RGB(116, 207, 148);
    self.moneyText.layer.cornerRadius = 5;
    self.moneyText.clipsToBounds = YES;
    self.moneyText.keyboardType=UIKeyboardTypeNumberPad;
    [topView addSubview:self.moneyText];
    
    
    payBtn = [UIButton createButton:CGRectMake(SCREEN_WIDTH - 100, 20, 80, 35) target:self action:@selector(payButtonClick:) radius:5];
    [payBtn setTitle:@"支出" size:15 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [payBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    payBtn.tag = 0;
    [topView addSubview:payBtn];
    
    
    incomeBtn = [UIButton createButton:CGRectMake(SCREEN_WIDTH - 100, payBtn.bottom + 10, 80, 35) target:self action:@selector(payButtonClick:) radius:5];
    [incomeBtn setTitle:@"收入" size:15 color:RGB(116, 207, 148) Highlighted:WhiteColor];
    [incomeBtn setBackgroundColor:RGB(229, 229, 229) Highlighted:RGB(116, 207, 148)];
    incomeBtn.tag = 1;
    [topView addSubview:incomeBtn];
    
    UIView *topline = [UIView new];
    topline.backgroundColor = GreenColor;
    topline.layer.cornerRadius = 2;
    topline.clipsToBounds = YES;
    topline.frame = CGRectMake(20 , self.moneyText.bottom + 10, SCREEN_WIDTH - 40, 0.5);
    [topView addSubview:topline];
    
    UIView *centerline = [UIView new];
    centerline.backgroundColor = GreenColor;
    centerline.layer.cornerRadius = 2;
    centerline.clipsToBounds = YES;
    centerline.frame = CGRectMake(SCREEN_WIDTH / 2 , topline.bottom + 10, 0.5, 30);
    [topView addSubview:centerline];
    
    UIView *bottomline = [UIView new];
    bottomline.backgroundColor = GreenColor;
    bottomline.layer.cornerRadius = 2;
    bottomline.clipsToBounds = YES;
    bottomline.frame = CGRectMake(20 , topline.bottom + 50, SCREEN_WIDTH - 40, 0.5);
    [topView addSubview:bottomline];
    
    UIImageView *dayImg = [[UIImageView alloc] initWithFrame:CGRectMake(25, topline.top + 15, 40 / 2, 40 / 2)];
    dayImg.image = [UIImage imageNamed:@"date"];
    [topView addSubview:dayImg];
    
    UIImageView *timeImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45, topline.top + 15, 40 / 2, 40 / 2)];
    timeImg.image = [UIImage imageNamed:@"time"];
    [topView addSubview:timeImg];
    
    self.dayLabel = [UILabel new];
    self.dayLabel.textColor = [UIColor blackColor];
    self.dayLabel.frame = CGRectMake(dayImg.right + 20, dayImg.top, 100, 20);
    self.dayLabel.font = font(12);
    [topView addSubview:self.dayLabel];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.frame = CGRectMake(timeImg.left - 20 - 100, dayImg.top, 100, 20);
    self.timeLabel.font = font(12);
    [topView addSubview:self.timeLabel];
    
    UIButton *timeBtn = [UIButton createButton:CGRectMake(0, topline.bottom, SCREEN_WIDTH , 50) target:self action:@selector(timeBtnClick:)];
    [topView addSubview:timeBtn];
    
    [self.view addSubview:topView];
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[HTKDragAndDropCollectionViewLayout alloc] init]];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self initCollectionView];
    
    
    UILabel *nameLab = [UILabel new];
    nameLab.textColor = [UIColor blackColor];
    nameLab.frame = CGRectMake(20, topView.bottom + 150, 40, 20);
    nameLab.font = font(12);
    nameLab.text = @"备注:";
    [self.view addSubview:nameLab];
    
    
    self.contentText = [[UITextView alloc]init];
    self.contentText.frame = CGRectMake(nameLab.right, nameLab.top, SCREEN_WIDTH - nameLab.width - 40, 30);
    self.contentText.font = font(14);
    self.contentText.textColor = RGB(116, 207, 148);
    self.contentText.layer.cornerRadius = 5;
    self.contentText.clipsToBounds = YES;
    [self.view addSubview:self.contentText];
    
    UIButton *saveBtn = [UIButton createButton:rect(SCREEN_WIDTH / 2 - 100, self.contentText.bottom + 20, 200, 35) target:self action:@selector(saveAccount) radius:5];
    [saveBtn setBackgroundColor:RGB(116, 207, 148) Highlighted:WhiteColor];
    [saveBtn setTitle:@"记一笔" size:20 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [self.view addSubview:saveBtn];
    
    
    [self updateTime:self.time];
}

- (void) initCollectionView
{
    [self.collectionView registerClass:[HTKSampleCollectionViewCell class] forCellWithReuseIdentifier:HTKDraggableCollectionViewCellIdentifier];
    // Setup item size
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    
    
    CGFloat itemWidth = CGRectGetWidth(self.collectionView.bounds) / 4 - 20;
    
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.lineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
//   [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
}

#pragma mark - UICollectionView Datasource/Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EBTags *eTags = [self.tagArray objectAtIndex:indexPath.row];
    
    HTKSampleCollectionViewCell *cell = (HTKSampleCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HTKDraggableCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.eTags = eTags;
    // Set our delegate for dragging
    cell.draggingDelegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    EBTags *eTags = [self.tagArray objectAtIndex:indexPath.row];
    self.selectTag = eTags;
    HTKSampleCollectionViewCell *cell = (HTKSampleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.clipsToBounds = YES;
    cell.backgroundColor = GreenColor;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HTKSampleCollectionViewCell *cell = (HTKSampleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}


#pragma mark - HTKDraggableCollectionViewCellDelegate

- (BOOL)userCanDragCell:(UICollectionViewCell *)cell {
    // All cells can be dragged in this demo
    return YES;
}

- (void)userDidEndDraggingCell:(UICollectionViewCell *)cell {
    
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    
    // Save our dragging changes if needed
    if (flowLayout.finalIndexPath != nil) {
        // Update datasource
        NSObject *objectToMove = [self.tagArray objectAtIndex:flowLayout.draggedIndexPath.row];
        [self.tagArray removeObjectAtIndex:flowLayout.draggedIndexPath.row];
        [self.tagArray insertObject:objectToMove atIndex:flowLayout.finalIndexPath.row];
    }
    
    // Reset
    [flowLayout resetDragging];
}



- (void)viewWillAppear:(BOOL)animated
{
    self.time = [NSDate date];
    [self updateTime:self.time];
}

- (void)timeBtnClick:(UIButton *)sender
{
    HSDatePickerViewController *hsdpvc = [[HSDatePickerViewController alloc] init];
    hsdpvc.date = self.time;
    hsdpvc.delegate = self;
    hsdpvc.mainColor = GreenColor;
    [self presentViewController:hsdpvc animated:YES completion:nil];
}

- (void)updateTime:(NSDate *)time
{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:time];
    
    self.dayLabel.text = [NSString stringWithFormat:@"%4ld年%2ld月%2ld日",[dateComponents year],[dateComponents month],[dateComponents day]];
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",[dateComponents hour],[dateComponents minute]];
}

- (void)payButtonClick:(UIButton *)button
{
    if (button.tag == 0)
    {
        self.isPay = YES;
        [payBtn setTitle:@"支出" size:15 color:WhiteColor Highlighted:RGB(116, 207, 148)];
        [payBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
        [incomeBtn setTitle:@"收入" size:15 color:RGB(116, 207, 148) Highlighted:WhiteColor];
        [incomeBtn setBackgroundColor:RGB(229, 229, 229) Highlighted:RGB(116, 207, 148)];
        self.tagArray = [SQLBaseManager getTagsWithType:self.isPay];
        [self.collectionView reloadData];
    }
    else
    {
        self.isPay = NO;
        [payBtn setTitle:@"支出" size:15 color:RGB(116, 207, 148) Highlighted:WhiteColor];
        [payBtn  setBackgroundColor:RGB(229, 229, 229) Highlighted:RGB(116, 207, 148)];
        [incomeBtn setTitle:@"收入" size:15 color:WhiteColor Highlighted:RGB(116, 207, 148)];
        [incomeBtn setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
        self.tagArray = [SQLBaseManager getTagsWithType:self.isPay];
        [self.collectionView reloadData];
    }
}

#pragma mark - HSDatePickerViewControllerDelegate
- (void)hsDatePickerPickedDate:(NSDate *)date {
    NSLog(@"Date picked %@", date);
    
    if ([date timeIntervalSinceDate:[NSDate date]] > 0.0)
    {
        date = [NSDate date];
    }
    
    self.time = date;
    [self updateTime:self.time];
}


- (void)saveAccount
{
    if ([self.moneyText.text intValue] < 1 || [self.moneyText.text intValue] > 9999999)
    {
        [[[iToast makeText:@"输入金额务必在1-9999999之间!"] setGravity:iToastGravityCenter] show];
        [self.moneyText becomeFirstResponder];
        return;
    }
    
    if (!self.selectTag)
    {
        [[[iToast makeText:@"类型为必选项!"] setGravity:iToastGravityCenter] show];
        return;
    }
    
    if (self.contentText.text.length > 70)
    {
        [[[iToast makeText:@"备注最多70个汉字,您不是在写作文"] setGravity:iToastGravityCenter] show];
        [self.contentText becomeFirstResponder];
        return;
    }
    
    Accounts *act = [[Accounts alloc]init];
    act.content = self.contentText.text;
    act.time = [MV_Utils dateWithDate:self.time withFormat:@"yyyy-MM-dd HH:mm:ss"];
    act.type = [NSString stringWithFormat:@"%d",self.isPay?0:1];
    act.tid = [NSString stringWithFormat:@"%d",self.selectTag.tid];
    
    if (self.isPay)
    {
        act.payprice = self.moneyText.text;
    }
    else
    {
        act.inprice = self.moneyText.text;
    }
    
    WKAlertViewStyle alertStyle;
    NSString *alertStr;
    
    if ([SQLBaseManager insertModel:act])
    {
        alertStyle = WKAlertViewStyleSuccess;
        alertStr = @"保存成功";
    }
    else
    {
        alertStyle = WKAlertViewStyleFail;
        alertStr = @"保存失败";
    }
    //为成员变量Window赋值则立即显示Window
    
    __sheetWindow = [WKAlertView showAlertViewWithStyle:alertStyle title:@"提示" detail:alertStr canleButtonTitle:nil okButtonTitle:@"确定" callBlock:^(MyWindowClick buttonIndex) {
        [self initData];
        //Window隐藏，并置为nil，释放内存 不能少
        __sheetWindow.hidden = YES;
        __sheetWindow = nil;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
