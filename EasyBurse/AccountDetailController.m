//
//  AccountDetailController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/3.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "AccountDetailController.h"
#import "SQLBaseManager.h"
#import "MV_TitleBar.h"

@interface AccountDetailController ()
{
    UIWindow *__sheetWindow ;//window必须为全局变量或成员变量
    Accounts *act;
}
@property (nonatomic,retain) UITextView *content;
@property (nonatomic,retain) UITextView *price;
@property (nonatomic,retain) UITextView *time;
@property (nonatomic,retain) UILabel *moneylab;
@property (nonatomic,retain) UIImageView *typeImg;
@property (nonatomic,retain) UIImageView *szImg;
@end

@implementation AccountDetailController
-(instancetype)init
{
    self = [super init];
    if (self) {
        //
        [self initUiView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)titleBarLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initUiView
{
    self.content = [UITextView new];
    self.content.textAlignment = NSTextAlignmentCenter;
    self.content.textColor = [UIColor blackColor];
    self.content.backgroundColor = [UIColor clearColor];
    self.content.font = font(14);
    [self.view addSubview:self.content];
    
    
    self.price = [UITextView new];
    self.price.textColor = [UIColor blackColor];
    self.price.backgroundColor = [UIColor clearColor];
    self.price.keyboardType=UIKeyboardTypeNumberPad;
    self.price.font = font(14);
    [self.view addSubview:self.price];
    
    self.time = [UITextView new];
    self.time.textAlignment = NSTextAlignmentCenter;
    self.time.textColor = [UIColor blackColor];
    self.time.backgroundColor = [UIColor clearColor];
    self.time.font = font(14);
    [self.view addSubview:self.time];
    
    self.szImg = [UIImageView new];
    [self.view addSubview:self.szImg];
    
    self.moneylab = [UILabel new];
    self.moneylab.textColor = [UIColor blackColor];
    self.moneylab.font = font(16);
    [self.view addSubview:self.moneylab];
    
    
    UIButton *delBtn = [UIButton createButton:CGRectMake(0, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH / 2 - 1, 50) target:self action:@selector(delBtnClick)];
    [delBtn setTitle:@"删除" size:20 color:RGB(229, 229, 229) Highlighted:RGB(116, 207, 148)];
    [delBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [self.view addSubview:delBtn];
    
    UIButton *modifBtn = [UIButton createButton:CGRectMake(SCREEN_WIDTH / 2 + 1, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH / 2, 50) target:self action:@selector(modifBtnClick)];
    [modifBtn setTitle:@"修改" size:20 color:RGB(229, 229, 229) Highlighted:RGB(116, 207, 148)];
    [modifBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [self.view addSubview:modifBtn];
}

- (void)delBtnClick
{
    //为成员变量Window赋值则立即显示Window
    __sheetWindow = [WKAlertView showAlertViewWithStyle:WKAlertViewStyleWaring title:@"提示" detail:@"确定删除吗？" canleButtonTitle:@"取消" okButtonTitle:@"确定" callBlock:^(MyWindowClick buttonIndex) {
        
        if (buttonIndex == MyWindowClickForOK)
        {
            [SQLBaseManager deleteData:act];
            [self titleBarLeftClick];
        }
        
        //Window隐藏，并置为nil，释放内存 不能少
        __sheetWindow.hidden = YES;
        __sheetWindow = nil;
        
    }];
}

- (void)modifBtnClick
{
    
    
    if (self.content.text.length < 1)
    {
        [[[iToast makeText:@"名称不能为空!"] setGravity:iToastGravityCenter] show];
        [self.content becomeFirstResponder];
        return;
    }
    
    if (self.content.text.length > 6)
    {
        [[[iToast makeText:@"名称最多六个汉字,您不是在写作文"] setGravity:iToastGravityCenter] show];
        [self.content becomeFirstResponder];
        return;
    }
    
    if (self.price.text.length < 1)
    {
        [[[iToast makeText:@"金额为必填项!"] setGravity:iToastGravityCenter] show];
        [self.price becomeFirstResponder];
        return;
    }
    
    act.content = self.content.text;
    ([act.type intValue] == 0)? (act.payprice = self.price.text): (act.inprice = self.price.text);
    
    //为成员变量Window赋值则立即显示Window
    __sheetWindow = [WKAlertView showAlertViewWithStyle:WKAlertViewStyleWaring title:@"提示" detail:@"确定修改吗？" canleButtonTitle:@"取消" okButtonTitle:@"确定" callBlock:^(MyWindowClick buttonIndex) {
        
        if (buttonIndex == MyWindowClickForOK)
        {
            [SQLBaseManager modifyData:act];
            [self titleBarLeftClick];
        }
        
        //Window隐藏，并置为nil，释放内存 不能少
        __sheetWindow.hidden = YES;
        __sheetWindow = nil;
        
    }];
}

-(void)viewDidLayoutSubviews
{
    self.moneylab.frame = CGRectMake(SCREEN_WIDTH / 2 - 80 / 2, NAVIGATION_BAR_HEIGHT + 23 , 80, 30);
    self.price.frame = CGRectMake(self.moneylab.right, NAVIGATION_BAR_HEIGHT + 21, 100, 40);
    self.time.frame = CGRectMake(SCREEN_WIDTH / 2 - 200 / 2, self.price.bottom + 5, 200, 30);
    self.content.frame = CGRectMake(SCREEN_WIDTH / 2 - 100 / 2, self.time.bottom + 5, 100, 30);
    self.szImg.frame = CGRectMake(self.moneylab.left - 25, self.price.top + 8, 32 / 2, 32 / 2);
    

}

-(void)initData:(Accounts *)account;
{
    act = account;
    if ([account.type intValue] == 0)
    {
        self.moneylab.text = @"支出：￥";
        self.price.text = [NSString stringWithFormat:@"%@",account.payprice];
        self.szImg.image = [UIImage imageNamed:@"income_icon"];
    }
    else
    {
        self.moneylab.text = @"收入：￥";
        self.price.text = [NSString stringWithFormat:@"%@",account.inprice];
        self.szImg.image = [UIImage imageNamed:@"expand_icon"];
    }
    
    self.time.text = account.time;
    self.content.text = account.content;
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
