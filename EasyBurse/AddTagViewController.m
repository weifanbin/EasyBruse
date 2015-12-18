//
//  AddTagViewController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/7.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "AddTagViewController.h"
#import "ZZPlaceholderTextView.h"
#import "SQLBaseManager.h"
#import "AddTagCell.h"

@interface AddTagViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIWindow *__sheetWindow ;//window必须为全局变量或成员变量
}
@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, strong) UIPickerView *pickerview;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) UIButton *selectViewBtn;
@property (nonatomic, strong) UIButton*cancelBtn;
@property (nonatomic, strong) UIButton*okBtn;
@property (nonatomic, strong) NSArray *typeArr;

@property (nonatomic, strong) ZZPlaceholderTextView *nameTextView;
@property (nonatomic, strong) ZZPlaceholderTextView *noteTextView;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSString *selectImgStr;

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic) int selectImgIndex;
@property (nonatomic, strong) EBTags *eTage;
@end

@implementation AddTagViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        //
        self.typeArr = @[@"支出",@"收入"];
        self.imageArr = @[@"yund",@"fangc",@"zidy",@"yul",@"youx",@"yingeyp",@"yil",@"yao",@"yanj",@"xuex",@"qit",@"other4",@"other3",@"other2",@"maj",@"jij",@"gup",@"gouw",@"gongz",@"diany",@"dap",@"cunk",@"chux",@"chongw",@"cany",@"biyt",@"zuf"];
        [self initUiView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void)initUiView
{
    UILabel *typeLab = [UILabel new];
    typeLab.textColor = UIColorFromRGB(0x959595, 1.0);
    typeLab.frame = CGRectMake( 20, NAVIGATION_BAR_HEIGHT + 20, 40, 20);
    typeLab.text = @"类别";
    typeLab.font = font(16);
    [self.view addSubview:typeLab];
    
    self.typeBtn = [UIButton createButton:CGRectMake(typeLab.right + 5, typeLab.top - 10, 150, 40) target:self action:@selector(typeBtnClick)];
    [self.typeBtn setTitle:@"支出" size:16 color:BlackColor Highlighted:BlackColor];
    self.typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //[self.typeBtn setBackgroundColor:[UIColor clearColor] Highlighted:[UIColor clearColor]];
    [self.view addSubview:self.typeBtn];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = UIColorFromRGB(0x959595, 1.0);
    line1.frame = CGRectMake(10, typeLab.bottom + 15, SCREEN_WIDTH - 20, 1);
    [self.view addSubview:line1];
    
    
    UILabel *nameLab = [UILabel new];
    nameLab.textColor = UIColorFromRGB(0x959595, 1.0);
    nameLab.frame = CGRectMake( 20, line1.bottom + 15, 40, 20);
    nameLab.text = @"名称";
    nameLab.font = font(16);
    [self.view addSubview:nameLab];
    
    self.nameTextView = [[ZZPlaceholderTextView alloc] initWithFrame:CGRectMake(nameLab.right, nameLab.top - 7, SCREEN_WIDTH - 80, 40)];
    self.nameTextView.textColor = [UIColor blackColor];
    self.nameTextView.backgroundColor = [UIColor clearColor];
    self.nameTextView.font = font(16);
    self.nameTextView.placeholder = @"给标签取个有代表性的名称";
    [self.view addSubview:self.nameTextView];
    
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = UIColorFromRGB(0x959595, 1.0);
    line2.frame = CGRectMake(10, nameLab.bottom + 15, SCREEN_WIDTH - 20, 0.5);
    [self.view addSubview:line2];
    
    UILabel *noteLab = [UILabel new];
    noteLab.textColor = UIColorFromRGB(0x959595, 1.0);
    noteLab.frame = CGRectMake( 20, line2.bottom + 15, 40, 20);
    noteLab.text = @"备注";
    noteLab.font = font(16);
    [self.view addSubview:noteLab];
    
    self.noteTextView = [[ZZPlaceholderTextView alloc] initWithFrame:CGRectMake(noteLab.right, noteLab.top - 7, SCREEN_WIDTH - 80, 40)];
    self.noteTextView.textColor = [UIColor blackColor];
    self.noteTextView.backgroundColor = [UIColor clearColor];
    self.noteTextView.font = font(16);
    self.noteTextView.placeholder = @"可以备注一下，自律、备忘、类别...";
    [self.view addSubview:self.noteTextView];
    
    UIView *line3 = [UIView new];
    line3.backgroundColor = UIColorFromRGB(0x959595, 1.0);
    line3.frame = CGRectMake(10, noteLab.bottom + 15, SCREEN_WIDTH - 20, 0.5);
    [self.view addSubview:line3];
    
    self.deleteBtn = [UIButton createButton:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH / 2 - 1, 50) target:self action:@selector(deleteBtnClick)];
    [self.deleteBtn setTitle:@"删除" size:20 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [self.deleteBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [self.view addSubview:self.deleteBtn];
    
    self.saveBtn = [UIButton createButton:CGRectMake(SCREEN_WIDTH / 2 + 1, SCREEN_HEIGHT - 50, SCREEN_WIDTH / 2, 50) target:self action:@selector(saveBtnClick)];
    [self.saveBtn setTitle:@"保存" size:20 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [self.saveBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [self.view addSubview:self.saveBtn];
    
    
    self.addBtn = [UIButton createButton:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50) target:self action:@selector(addBtnClick)];
    [self.addBtn setTitle:@"添加" size:20 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [self.addBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [self.view addSubview:self.addBtn];
    
    //----create collectionView
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, SCREEN_HEIGHT - 300) collectionViewLayout:flowLayout];
    
    self.collection.dataSource=self;
    self.collection.delegate=self;
    [self.collection setBackgroundColor:[UIColor clearColor]];
    [self.collection registerClass:[AddTagCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.collection];
    
    
    [self addPickerView];
}

-(void)initData:(EBTags *)eTage;
{
    self.eTage = eTage;
    
    self.nameTextView.text = eTage.tname;
    if (eTage.tnote.length > 1) self.noteTextView.text = eTage.tnote;
    NSString *btnStr = (([eTage.ttype intValue] == 0)?@"支出":@"收入");
    [self.typeBtn setTitle:btnStr];
    self.selectImgStr = eTage.timage;
    
    [self.collection selectItemAtIndexPath:[NSIndexPath indexPathForRow:[self.imageArr indexOfObject:eTage.timage] inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    
    self.addBtn.hidden = YES;
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    NSString *imgStr = [self.imageArr objectAtIndex:indexPath.row];
    
    AddTagCell * cell = (AddTagCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.str = imgStr;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectImgStr = [self.imageArr objectAtIndex:indexPath.row];
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

- (void)typeBtnClick
{
    self.selectView.hidden = NO;
    [self.pickerview selectRow:0 inComponent:0 animated:NO];
}

- (void)okBtnTapped
{
    self.selectView.hidden = YES;
    
    NSInteger row = [self.pickerview selectedRowInComponent:0];
    [self.typeBtn setTitle:[self.typeArr objectAtIndex:row]];
}

- (void)cancelBtnTapped
{
    self.selectView.hidden = YES;
}

- (void)deleteBtnClick
{
    //为成员变量Window赋值则立即显示Window
    __sheetWindow = [WKAlertView showAlertViewWithStyle:WKAlertViewStyleWaring title:@"提示" detail:@"相同类型的账目会一并删除？" canleButtonTitle:@"取消" okButtonTitle:@"确定" callBlock:^(MyWindowClick buttonIndex) {
        
        if (buttonIndex == MyWindowClickForOK)
        {
            [SQLBaseManager deleteTagData:self.eTage];
            [self titleBarLeftClick];
        }
        
        //Window隐藏，并置为nil，释放内存 不能少
        __sheetWindow.hidden = YES;
        __sheetWindow = nil;
        
    }];
}

- (void)saveBtnClick
{
    if (self.nameTextView.text.length < 1)
    {
        [[[iToast makeText:@"标签名称为必填项!"] setGravity:iToastGravityCenter] show];
        [self.nameTextView becomeFirstResponder];
        return;
    }
    
    if (self.noteTextView.text.length > 1)
    {
        [[[iToast makeText:@"备注内容不是写作文请小于70个字!"] setGravity:iToastGravityCenter] show];
        [self.noteTextView becomeFirstResponder];
        return;
    }
    
    if (self.selectImgStr.length < 1)
    {
        [[[iToast makeText:@"请选择种类图片!"] setGravity:iToastGravityCenter] show];
        return;
    }
    
    self.eTage.timage = self.selectImgStr;
    self.eTage.tname = self.nameTextView.text;
    (self.noteTextView.text.length > 1)? (self.eTage.tnote = self.noteTextView.text): (self.eTage.tnote = @"");
    [[self.typeBtn titleForState:UIControlStateNormal] isEqualToString:@"支出"]?(self.eTage.ttype = @"0"):(self.eTage.ttype = @"1");
    
    
    //为成员变量Window赋值则立即显示Window
    __sheetWindow = [WKAlertView showAlertViewWithStyle:WKAlertViewStyleWaring title:@"提示" detail:@"确定修改吗？" canleButtonTitle:@"取消" okButtonTitle:@"确定" callBlock:^(MyWindowClick buttonIndex) {
        
        if (buttonIndex == MyWindowClickForOK)
        {
            [SQLBaseManager modifyTagData:self.eTage];
            [self titleBarLeftClick];
        }
        //Window隐藏，并置为nil，释放内存 不能少
        __sheetWindow.hidden = YES;
        __sheetWindow = nil;
        
    }];
}

- (void)addBtnClick
{
    if (self.nameTextView.text.length < 1)
    {
        [[[iToast makeText:@"标签名称为必填项!"] setGravity:iToastGravityCenter] show];
        [self.nameTextView becomeFirstResponder];
        return;
    }
    
    if (self.noteTextView.text.length > 70)
    {
        [[[iToast makeText:@"备注内容不是写作文请小于70个字!"] setGravity:iToastGravityCenter] show];
        [self.noteTextView becomeFirstResponder];
        return;
    }
    
    if (self.selectImgStr.length < 1)
    {
        [[[iToast makeText:@"请选择种类图片!"] setGravity:iToastGravityCenter] show];
        return;
    }
    
    EBTags *eTag = [[EBTags alloc]init];
    eTag.tname = self.nameTextView.text;
    eTag.timage = self.selectImgStr;
    (self.noteTextView.text.length > 1)? (eTag.tnote = self.noteTextView.text): (eTag.tnote = @"");
    [[self.typeBtn titleForState:UIControlStateNormal] isEqualToString:@"支出"]?(eTag.ttype = @"0"):(eTag.ttype = @"1");
    
    WKAlertViewStyle alertStyle;
    NSString *alertStr;
    
    if ([SQLBaseManager insertTagModel:eTag])
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
        //Window隐藏，并置为nil，释放内存 不能少
        __sheetWindow.hidden = YES;
        __sheetWindow = nil;
        [self titleBarLeftClick];
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.typeArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.typeArr objectAtIndex:row];
}



- (void)titleBarLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
