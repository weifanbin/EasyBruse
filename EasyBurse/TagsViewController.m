//
//  TagsViewController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "TagsViewController.h"
#import "SQLBaseManager.h"
#import "TagCell.h"
#import "AddTagViewController.h"

@interface TagsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *tagArray;
@property (nonatomic,retain) UITableView *table;

@end

@implementation TagsViewController

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
    
    [self initData];
    
    UIButton *addBtn = [UIButton createButton:CGRectMake(0, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - MENUS_HEIGHT - 50, SCREEN_WIDTH, 50) target:self action:@selector(addBtnClick)];
    [addBtn setTitle:@"添加" size:20 color:WhiteColor Highlighted:RGB(116, 207, 148)];
    [addBtn  setBackgroundColor:RGB(116, 207, 148) Highlighted:RGB(229, 229, 229)];
    [self.view addSubview:addBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initData];
    [self.table reloadData];
}

- (void)addBtnClick
{
    AddTagViewController *addVC = [[AddTagViewController alloc]init];
    
//    EBViewController *ebv =  (EBViewController *)self.navigationController;
//    [ebv.titleBar resetTitle:@"添加标签"];
//    [ebv.titleBar setLeftButtonType:MV_TitleBarButtonStyle_Back];
//    ebv.titleBar.delegate = addVC;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)initData
{
    self.tagArray = [SQLBaseManager getTags];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor = UIColorFromRGB(0xe6f6ec, 1.0);
    
    EBTagType *eType = [self.tagArray objectAtIndex:section];
    
    UILabel *typeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 13, 150, 20)];
    typeLab.textColor = [UIColor blackColor];
    typeLab.font = font(14);
    typeLab.text = ([eType.ttype intValue] == 0)?@"支出标签":@"收入标签";
    [headerView addSubview:typeLab];
    
    UIView *topline = [UIView new];
    topline.backgroundColor = GreenColor;
    topline.layer.cornerRadius = 2;
    topline.clipsToBounds = YES;
    topline.frame = CGRectMake(10 , 0, SCREEN_WIDTH - 10, 0.5);
    [headerView addSubview:topline];
    
    UIView *bottomline = [UIView new];
    bottomline.backgroundColor = GreenColor;
    bottomline.layer.cornerRadius = 2;
    bottomline.clipsToBounds = YES;
    bottomline.frame = CGRectMake(10 , headerView.bottom - 0.5, SCREEN_WIDTH - 10, 0.5);
    [headerView addSubview:bottomline];

    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tagArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    EBTagType *eType = [self.tagArray objectAtIndex:section];
    return eType.tagArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EBTagType *eType = [self.tagArray objectAtIndex:indexPath.section];
    EBTags *eTag = [eType.tagArr objectAtIndex:indexPath.row];
    
    static NSString *CMainCell = @"Tags";     //  0
    
    TagCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];      //   1
    if (cell == nil) {
        cell = [[TagCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];    //  2
    }
    cell.tag = eTag;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EBTagType *eType = [self.tagArray objectAtIndex:indexPath.section];
    EBTags *eTag = [eType.tagArr objectAtIndex:indexPath.row];
    
    AddTagViewController *addVC = [[AddTagViewController alloc]init];
    
//    EBViewController *ebv =  (EBViewController *)self.navigationController;
//    [ebv.titleBar resetTitle:@"标签详情"];
//    [ebv.titleBar setLeftButtonType:MV_TitleBarButtonStyle_Back];
//    ebv.titleBar.delegate = addVC;
    [addVC initData:eTag];
    [self.navigationController pushViewController:addVC animated:YES];
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
