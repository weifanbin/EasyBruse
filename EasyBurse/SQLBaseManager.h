//
//  SQLBaseManager.h
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Accounts.h"
#import "EBTags.h"

@interface SQLBaseManager : NSObject

// 插入模型数据
+ (BOOL)insertModel:(Accounts *)model;
/** 删除数据,如果 传空 默认会删除表中所有数据 */
+ (BOOL)deleteData:(Accounts *)model;
/** 修改数据 */
+ (BOOL)modifyData:(Accounts *)model;
/** 查询数据,如果 传空 默认会查询表中所有数据 */
+ (NSMutableArray *)getAccountsByYear:(NSInteger)year;

+ (NSMutableArray *)getAccountsBySelect:(NSString *)sqlStr;// 根据传入条件进行查询

+ (NSMutableArray *)getAccountsNum;// 获得日期分类


//+ (BOOL)existData:(Accounts *)model;

+ (NSMutableArray *)getTags;            // 获取全部标签分好组
+ (NSMutableArray *)getTagsWithType:(BOOL)ttype;    // 根据收入支出返回不同类型标签
+ (NSMutableArray *)getAllTags;         // 获取全部tag部分类型
+ (EBTags *)getTagsWithTid:(NSString *)tid;
+ (BOOL)insertTagModel:(EBTags *)model;
+ (BOOL)deleteTagData:(EBTags *)model;
+ (BOOL)modifyTagData:(EBTags *)model;
@end
