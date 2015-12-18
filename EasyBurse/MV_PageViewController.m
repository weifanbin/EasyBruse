//
//  MV_PageViewController.m
//  MyTreasure
//
//  Created by Bryan on 15/11/17.
//  Copyright © 2015年 makervt. All rights reserved.
//

#import "MV_PageViewController.h"
#import "SaveViewController.h"
#import "BooksViewController.h"
#import "TagsViewController.h"
#import "MoreViewController.h"

@interface MV_PageViewController ()

@end

@implementation MV_PageViewController


-(instancetype)init
{
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
            {
                vcClass = [SaveViewController class];
                title = @"记一笔";
            }
                break;
            case 1:
            {
                vcClass = [BooksViewController class];
                title = @"账簿";
            }
                break;
            case 2:
            {
                vcClass = [TagsViewController class];
                title = @"标签";
            }
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
//    return [self initWithNibName:@"MV_PageViewController" bundle:nil];
    return [self initWithViewControllerClasses:viewControllers andTheirTitles:titles];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
