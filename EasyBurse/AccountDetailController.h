//
//  AccountDetailController.h
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/3.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MV_BaseViewController.h"
#import "Accounts.h"

@interface AccountDetailController : MV_BaseViewController<MV_TitleBarDelegate>

@property (nonatomic, strong) MV_TitleBar *titleBar;

-(void)initData:(Accounts *)account;
@end
