//
//  MoreViewController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "MoreViewController.h"
#import "YLInitSwipePasswordController.h"
#import "KLSwitch.h"
#import "UMSocial.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
@property (nonatomic,retain) UITableView *table;
@property (nonatomic,retain) NSArray *titleArr;
@property (nonatomic,retain) NSArray *imageArr;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleArr = @[@"云同步",@"安全设置",@"关于点滴记账",@"求给个评价吧！"];
    self.imageArr = @[@"icon_export_import",@"icon_security",@"icon_about",@"icon_support"];
    self.view.backgroundColor = self.view.backgroundColor = RGB(240, 240, 240);
    
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.frame = CGRectMake(0, MENUS_HEIGHT, SCREEN_WIDTH, 300);
    self.table.backgroundColor = [UIColor whiteColor];
    //self.table.tableFooterView = [[UIView alloc] init];

    [self.view addSubview:self.table];
}

-(void)titleBarLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"Books";     //  0
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];      //   1
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];    //  2
    }
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.imageArr objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == 1)
    {
        KLSwitch *klSwitch = [[KLSwitch alloc]initWithFrame:CGRectMake(cell.frame.size.width - 40, 15, 50, 25)];
        [klSwitch setOnTintColor:GreenColor];
        [klSwitch setOn:[MV_Utils getPassWord] animated: YES];
        [klSwitch setDidChangeHandler:^(BOOL isOn) {
            NSLog(@"Smallest switch changed to %d", isOn);
            if (isOn)
            {
                YLInitSwipePasswordController *controller = [YLInitSwipePasswordController new];
                [self presentViewController:controller animated:YES completion:nil];
            }
            else
            {
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault removeObjectForKey:@"gesturePassword"];
            }
        }];
        [cell addSubview:klSwitch];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==3)
    {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"5670c678e0f55a6e7d001119"
                                          shareText:@"你要分享的文字"
                                         shareImage:[UIImage imageNamed:@"icon.png"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,nil]
                                           delegate:self];
    }
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if (platformName == UMShareToSina) {
        socialData.shareText = @"分享到新浪微博的文字内容";
    }
    else{
        socialData.shareText = @"点滴记账分享给大三哥的文字内容";
    }
}

// 分享完成
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"response = %@",response);
}

@end
