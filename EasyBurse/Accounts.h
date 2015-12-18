//
//  Accounts.h
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountsNum : NSObject
@property (nonatomic,retain) NSString *time;            // 日期
@property (nonatomic,retain) NSString *num;             // 总条数
@property (nonatomic,retain) NSString *incomeSum;       // 收入合计
@property (nonatomic,retain) NSString *paySum;          // 支出合计
@property (nonatomic,retain) NSMutableArray *accountArr;
@end

@interface Accounts : NSObject

@property (nonatomic) int aid;
@property (nonatomic,retain) NSString *inprice;     // 收入金额
@property (nonatomic,retain) NSString *payprice;    // 支出金额
@property (nonatomic,retain) NSString *time;        // 时间
@property (nonatomic,retain) NSString *tid;         // 标签ID
@property (nonatomic,retain) NSString *tname;       // 标签名称
@property (nonatomic,retain) NSString *type;        // 类别(0.支出 1.收入)
@property (nonatomic,retain) NSString *content;     // 备注
@end
