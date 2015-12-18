//
//  YLCheckToUnlockViewController.m
//  YLSwipeLockViewDemo
//
//  Created by 肖 玉龙 on 15/2/28.
//  Copyright (c) 2015年 Yulong Xiao. All rights reserved.
//

#import "YLCheckToUnlockViewController.h"
#import "YLSwipeLockView.h"
@interface YLCheckToUnlockViewController ()<YLSwipeLockViewDelegate>
@property (nonatomic, weak) YLSwipeLockView *lockView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic) NSUInteger unmatchCounter;
@property (nonatomic, weak) UILabel *counterLabel;
@end

@implementation YLCheckToUnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:35/255.0 green:39/255.0 blue:54/255.0 alpha:1];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"滑动解锁";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(10, 60, self.view.bounds.size.width - 20, 20);
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, self.view.bounds.size.width - 20, 20)];
    counterLabel.textColor = [UIColor redColor];
    counterLabel.textAlignment = NSTextAlignmentCenter;
    counterLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:counterLabel];
    self.counterLabel = counterLabel;
    self.counterLabel.hidden = YES;
    
    
    CGFloat viewWidth = self.view.bounds.size.width - 40;
    CGFloat viewHeight = viewWidth;
    
    YLSwipeLockView *lockView = [[YLSwipeLockView alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height - viewHeight - 40 - 100, viewWidth, viewHeight)];
    [self.view addSubview:lockView];
    
    self.lockView = lockView;
    self.lockView.delegate = self;
    
    self.unmatchCounter = 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(YLSwipeLockViewState)swipeView:(YLSwipeLockView *)swipeView didEndSwipeWithPassword:(NSString *)password
{
    NSString *savedPassword = [MV_Utils getPassWord];
    if ([savedPassword isEqualToString:password]) {
        [MV_Utils setHavePass:YES];
        
        [self dismiss];
        return YLSwipeLockViewStateNormal;
    }else{
        self.unmatchCounter--;
        if (self.unmatchCounter == 0) {
            self.counterLabel.text = @"请等待5分钟重试";
            self.counterLabel.hidden = NO;
            self.view.userInteractionEnabled = NO;
            
            [self performSelector:@selector(reset) withObject:nil afterDelay:3];
            
        }else {
            self.counterLabel.text = [NSString stringWithFormat:@"%d次输入机会", (unsigned long)self.unmatchCounter];
            self.counterLabel.hidden = NO;
        }
        return YLSwipeLockViewStateWarning;
    }
}

- (void)reset
{
    self.unmatchCounter = 3;
    self.counterLabel.text = [NSString stringWithFormat:@"%d次输入机会", (unsigned long)self.unmatchCounter];
    self.view.userInteractionEnabled = YES;
}

-(void)dismiss{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
