//
//  Accounts.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "Accounts.h"

@implementation Accounts

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.inprice = @"0";     // 收入金额
        self.payprice = @"0";    // 支出金额
    }
    return self;
}
@end

@implementation AccountsNum
@end