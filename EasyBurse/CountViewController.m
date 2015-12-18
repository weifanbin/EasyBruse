//
//  CountViewController.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/8.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "CountViewController.h"
#import "Example2PieView.h"
#import "MyPieElement.h"
#import "PieLayer.h"
#import "Accounts.h"

@interface CountViewController ()
@property (nonatomic, retain) Example2PieView* pieView;
@end

@implementation CountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//        [ebv.titleBar setLeftButtonType:MV_TitleBarButtonStyle_Back];
//    for(NSDictionary *dict in self.dataArray)
//    {
//        [dict objectForKey:@"支出"];
//        MyPieElement* elem = [MyPieElement pieElementWithValue:(5+arc4random()%8) color:[self randomColor]];
//        elem.title = [NSString stringWithFormat:@"%d year", year];
//        [self.pieView.layer addValues:@[elem] animated:YES];
//    }
    

}

-(void)viewWillAppear:(BOOL)animated
{
    EBViewController *ebv =  (EBViewController *)self.navigationController;
    [ebv.titleBar resetTitle:@"收支概况"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    int payMoney = 0;
    int incomeMoney = 0;
    for (AccountsNum *aNum in dataArray)
    {
        for (Accounts *accounts in aNum.accountArr)
        {
            if ([accounts.type intValue] == 0)
            {
                payMoney += [accounts.payprice intValue];
            }
            else
            {
                incomeMoney += [accounts.inprice intValue];
            }
        }
    }
    
    MyPieElement* elem = [MyPieElement pieElementWithValue:(payMoney) color:RedColor];
    elem.title = [NSString stringWithFormat:@"支出:%d￥",payMoney];
    [self.pieView.layer addValues:@[elem] animated:NO];
    
    MyPieElement* elem1 = [MyPieElement pieElementWithValue:(incomeMoney) color:GreenColor];
    elem1.title = [NSString stringWithFormat:@"收入:%d￥",incomeMoney];
    [self.pieView.layer addValues:@[elem1] animated:NO];
    
    //mutch easier do this with array outside
    self.pieView.layer.transformTitleBlock = ^(PieElement* elem){
        return [(MyPieElement*)elem title];
    };
    self.pieView.layer.showTitles = ShowTitlesAlways;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        //
        [self initUiView];
    }
    return self;
}

- (void)initUiView
{
    self.pieView = [[Example2PieView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 20, SCREEN_WIDTH, 320)];
    self.pieView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pieView];
}

- (void)titleBarLeftClick
{
    EBViewController *ebv =  (EBViewController *)self.navigationController;
    [ebv.titleBar resetTitle:@"点滴记账"];
    [ebv.titleBar setLeftButtonType:MV_TitleBarButtonStyle_None];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
