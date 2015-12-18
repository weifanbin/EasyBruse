//
//  BooksViewController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "BooksViewController.h"
#import "SQLBaseManager.h"
#import "Accounts.h"
#import "BooksCell.h"
#import "AccountDetailController.h"
#import "SelectViewController.h"
#import "CountViewController.h"

/**
 * UITableView的类型
 */
typedef NS_ENUM(NSInteger, UITableViewType){
    
    UITableViewType_Plain,
    
    UITableViewType_Group,
};

@interface BooksViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *bookArray;
@property (nonatomic,retain) UITableView *table;
@property (nonatomic) BOOL isSelectArray;
@end

@implementation BooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.titleBar resetTitle:@"快记账"];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - MENUS_HEIGHT - 50);
    [self.view addSubview:self.table];
    
    UIButton *selectBtn = [UIButton createButton:CGRectMake(0, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - MENUS_HEIGHT - 50, SCREEN_WIDTH / 2 - 1, 50) target:self action:@selector(selectBtnClick)];
    [selectBtn  setBackgroundColor:UIColorFromRGB(0xe6f6ec, 1.0) Highlighted:RGB(229, 229, 229)];
    [selectBtn setImage:[UIImage imageNamed:@"search_green"] forState:UIControlStateNormal];
    [self.view addSubview:selectBtn];
    
    UIButton *countBtn = [UIButton createButton:CGRectMake(SCREEN_WIDTH / 2 + 1, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - MENUS_HEIGHT - 50, SCREEN_WIDTH / 2, 50) target:self action:@selector(countBtnClick)];
    [countBtn  setBackgroundColor:UIColorFromRGB(0xe6f6ec, 1.0) Highlighted:RGB(229, 229, 229)];
    [countBtn setImage:[UIImage imageNamed:@"statistical_green"] forState:UIControlStateNormal];
    [self.view addSubview:countBtn];
    
    [self initData];
}

- (void)selectBtnClick
{
    WeaklySelf(weakSelf);
    SelectViewController *selectVC = [[SelectViewController alloc]init];
    selectVC.rf = ^(NSMutableArray* selectArray){
        [weakSelf refreshData:selectArray];
    };
    [self.navigationController pushViewController:selectVC animated:YES];
}

- (void)countBtnClick
{
    CountViewController *countVC = [[CountViewController alloc]init];
    countVC.dataArray = self.bookArray;
    [self.navigationController pushViewController:countVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.isSelectArray)
    {
        [self initData];
        [self.table reloadData];
    }
}

- (void)initData
{
      self.bookArray = [SQLBaseManager getAccountsByYear:[MV_Utils getYear]];
}

- (void)refreshData:(NSMutableArray *)selectArray;
{
    self.isSelectArray = YES;
    self.bookArray = selectArray;
    [self.table reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor = UIColorFromRGB(0xe6f6ec, 1.0);
    
    AccountsNum *aNum = [self.bookArray objectAtIndex:section];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
    timeLab.textColor = [UIColor blackColor];
    timeLab.font = font(14);
    timeLab.text = aNum.time;
    [headerView addSubview:timeLab];
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 20, 100, 30)];
    countLab.textAlignment = NSTextAlignmentRight;
    countLab.textColor = [UIColor grayColor];
    countLab.font = font(12);
    countLab.text = [NSString stringWithFormat:@"记录数 %@",aNum.num];
    [headerView addSubview:countLab];
    
    UILabel *incomeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 30)];
    incomeLab.textColor = [UIColor grayColor];
    incomeLab.font = font(12);
    incomeLab.text = [NSString stringWithFormat:@"收入总额 %@",aNum.incomeSum];
    [headerView addSubview:incomeLab];
    
    UILabel *payLab = [[UILabel alloc] initWithFrame:CGRectMake(incomeLab.right + 20, 20, 100, 30)];
    payLab.textColor = [UIColor grayColor];
    payLab.font = font(12);
    payLab.text = [NSString stringWithFormat:@"支出总额 %@",aNum.paySum];
    [headerView addSubview:payLab];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.bookArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountsNum *aNum = [self.bookArray objectAtIndex:indexPath.section];
    Accounts *account = [aNum.accountArr objectAtIndex:indexPath.row];
    
    static NSString *CMainCell = @"Books";     //  0
    
    BooksCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];      //   1
    if (cell == nil) {
        cell = [[BooksCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];    //  2
    }
    cell.account = account;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AccountsNum *aNum = [self.bookArray objectAtIndex:section];
    return aNum.accountArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    AccountsNum *aNum = [self.bookArray objectAtIndex:indexPath.section];
    Accounts *account = [aNum.accountArr objectAtIndex:indexPath.row];
    
    AccountDetailController *detailVC = [[AccountDetailController alloc]init];
    

    [detailVC initData:account];
    [self.navigationController pushViewController:detailVC animated:YES];
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
