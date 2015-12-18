//
//  EBViewController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/4.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "EBViewController.h"
#import "MoreViewController.h"

@interface EBViewController ()

@end

@implementation EBViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setHidden:YES];
    if (IOS_7_OR_LATER) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    self.titleBar = [[MV_TitleBar alloc] initWithTitle:@"" leftButtonType:MV_TitleBarButtonStyle_Back rightButtonType:MV_TitleBarButtonStyle_WhiteMore];
    [self.titleBar resetTitle:@"点滴记账"];
    self.titleBar.delegate = self;
    [self.view addSubview:self.titleBar];
    
    //[self topView];
}

- (void)topView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
    topView.backgroundColor = GreenColor;
    [self.view addSubview:topView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, 20, 100, 20)];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = font(22);
    titleLab.text = @"点滴记账";
    [topView addSubview:titleLab];
}

//-(MV_TitleBar *)titleBar
//{
//    if (!_titleBar) {
//        
//        _titleBar = [[MV_TitleBar alloc] initWithTitle:@"" leftButtonType:MV_TitleBarButtonStyle_None rightButtonType:MV_TitleBarButtonStyle_WhiteMore];
//    }
//    return _titleBar;
//}

-(void)titleBarLeftClick
{
    [self.titleBar resetTitle:@"点滴记账"];
    [self popViewControllerAnimated:YES];
}

-(void)titleBarRightClick
{
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    [self.titleBar setLeftButtonType:MV_TitleBarButtonStyle_Back];
    
    [self pushViewController:moreVC animated:YES];
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
