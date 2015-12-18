//
//  SQLBaseManager.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "SQLBaseManager.h"
#import <FMDatabase.h>

#define DATABASE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/easyBurse.sqlite"]

@implementation SQLBaseManager

static FMDatabase *_fmdb;

//SELECT count(*),time from 'Accounts'  GROUP BY strftime('%Y-%m-%d',  time)
//SELECT * from 'Accounts'  where strftime('%Y-%m-%d',time) =  '2015-12-02'

//SELECT * FROM (SELECT count(1) AS cnt,strftime('%Y-%m-%d',z.time)date3 FROM accounts z GROUP BY  strftime('%Y-%m-%d',z.time)) c LEFT JOIN (SELECT sum(x.price) AS price1,strftime('%Y-%m-%d',x.time) date1,x.type type1 FROM accounts x WHERE x.type = 0 GROUP BY strftime('%Y-%m-%d',x.time)) a left join(SELECT sum(y.price) AS price2,strftime('%Y-%m-%d',y.time) date2,y.type type2 FROM accounts y WHERE y.type = 1 GROUP BY strftime('%Y-%m-%d',y.time)) b on a.date1=b.date2

#pragma mark--------账目表管理
+ (NSMutableArray *)getAccountsByYear:(NSInteger)year {
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [SQLBaseManager checkTableCreatedInDb:db];
    
   NSString *selectStr = @"SELECT count(*) AS cnt,time,SUM(payprice) AS payprice,SUM(inprice) AS inprice from 'Accounts' WHERE time like '%%2015%%' GROUP BY strftime('%Y-%m-%d',time) ORDER BY time DESC";
    
    FMResultSet *rs = [db executeQuery:selectStr];
    while ([rs next]) {
        AccountsNum *account = [[AccountsNum alloc] init];
        account.num = [rs stringForColumn:@"cnt"];
        account.time = [MV_Utils styleDateFrom:[rs stringForColumn:@"time"]];
        account.paySum = [rs stringForColumn:@"payprice"];
        account.incomeSum = [rs stringForColumn:@"inprice"];;
        [dataArray addObject:account];
    }
    [rs close];
    
    for (AccountsNum *num in dataArray)
    {
        num.accountArr = [NSMutableArray arrayWithCapacity:0];
        NSString *sql1 = [NSString stringWithFormat:@"SELECT Accounts.id, inprice, payprice, time, type, tid, tname, content from 'Accounts','Tags' where time like '%@%%' and Accounts.tid = Tags.id",num.time];
        FMResultSet *rs = [db executeQuery:sql1];
        while ([rs next]) {
            Accounts *account = [[Accounts alloc] init];
            account.aid = [rs intForColumn:@"id"];
            account.content = [rs stringForColumn:@"content"];
            account.inprice = [rs stringForColumn:@"inprice"];
            account.payprice = [rs stringForColumn:@"payprice"];
            account.time = [rs stringForColumn:@"time"];
            account.type = [rs stringForColumn:@"type"];
            account.tid = [rs stringForColumn:@"tid"];
            account.tname = [rs stringForColumn:@"tname"];
            [num.accountArr addObject:account];
        }
        [rs close];
    }
    
    [db close];
    return dataArray;
}

+ (NSMutableArray *)getAccountsNum
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [SQLBaseManager checkTableCreatedInDb:db];
    
    NSString *selectStr = @"SELECT count(*) AS cnt,time,SUM(payprice) AS payprice,SUM(inprice) AS inprice from 'Accounts'  GROUP BY strftime('%Y-%m-%d',time) ORDER BY time DESC";
    
    FMResultSet *rs = [db executeQuery:selectStr];
    while ([rs next]) {
        AccountsNum *account = [[AccountsNum alloc] init];
        account.num = [rs stringForColumn:@"cnt"];
        account.time = [MV_Utils styleDateFrom:[rs stringForColumn:@"time"]];
        account.paySum = [rs stringForColumn:@"payprice"];
        account.incomeSum = [rs stringForColumn:@"inprice"];;
        account.accountArr = [NSMutableArray new];
        [dataArray addObject:account];
    }
    [rs close];
    [db close];
    return dataArray;
}

+ (NSMutableArray *)getAccountsBySelect:(NSString *)sqlStr;
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [SQLBaseManager checkTableCreatedInDb:db];

    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM 'Accounts' %@",sqlStr];
    NSLog(@"查询条件 = %@",sql);
    
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        Accounts *account = [[Accounts alloc] init];
        account.aid = [rs intForColumn:@"id"];
        account.content = [rs stringForColumn:@"content"];
        account.inprice = [rs stringForColumn:@"inprice"];
        account.payprice = [rs stringForColumn:@"payprice"];
        account.time = [rs stringForColumn:@"time"];
        account.type = [rs stringForColumn:@"type"];
        account.tid = [rs stringForColumn:@"tid"];
        [dataArray addObject:account];
    }
    [rs close];
    [db close];
    return dataArray;
}


+ (BOOL)insertModel:(Accounts *)model;
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [SQLBaseManager checkTableCreatedInDb:db];
    NSString *insertStr = @"INSERT INTO 'Accounts' ('content', 'inprice' , 'payprice', 'time' ,'tid', 'type') VALUES (?,?,?,?,?,?)";
    BOOL worked = [db executeUpdate:insertStr, model.content, model.inprice,model.payprice, model.time,model.tid, model.type];
    [db close];
    return worked;
}

+ (BOOL)deleteData:(Accounts *)model;
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [SQLBaseManager checkTableCreatedInDb:db];
    BOOL worked = [db executeUpdate:@"delete from 'Accounts' where id = ?", @(model.aid)];
    [db close];
    return worked;
}

+ (BOOL)modifyData:(Accounts *)model;
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [SQLBaseManager checkTableCreatedInDb:db];
    BOOL worked = [db executeUpdate:@"update 'Accounts' set  content = ?, inprice = ?, payprice = ?, time = ?, tid = ?, type = ? where id = ?", model.content, model.inprice,model.payprice, model.time, model.tid, model.type, [NSNumber numberWithInt:model.aid]];
    [db close];
    return worked;
}

+ (BOOL)checkTableCreatedInDb:(FMDatabase *)db {
    NSString *createStr = @"CREATE TABLE IF NOT EXISTS Accounts(id INTEGER PRIMARY KEY, inprice TEXT NOT NULL, payprice TEXT NOT NULL, time TEXT NOT NULL, tid TEXT NOT NULL, type TEXT NOT NULL, content TEXT NOT NULL);";
    BOOL worked = [db executeUpdate:createStr];
    //    FMDBQuickCheck(worked);
    return worked;
}


#pragma mark--------标签表管理

+ (NSMutableArray *)getTags {
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [SQLBaseManager checkTGTableCreatedInDb:db];
    
    NSString *selectStr = @"SELECT count(*) AS cnt,ttype from 'Tags'  GROUP BY ttype";
    
    FMResultSet *rs = [db executeQuery:selectStr];
    while ([rs next]) {
        EBTagType *eType = [[EBTagType alloc] init];
        eType.ttype = [rs stringForColumn:@"ttype"];
        [dataArray addObject:eType];
    }
    [rs close];
    
    for (EBTagType *etype in dataArray)
    {
        etype.tagArr = [NSMutableArray arrayWithCapacity:0];
        NSString *sql1 = [NSString stringWithFormat:@"SELECT * from 'Tags' where ttype = '%@'",etype.ttype];
        FMResultSet *rs = [db executeQuery:sql1];
        while ([rs next]) {
            EBTags *etage = [[EBTags alloc] init];
            etage.tid = [rs intForColumn:@"id"];
            etage.tname = [rs stringForColumn:@"tname"];
            etage.timage = [rs stringForColumn:@"timage"];
            etage.tnote = [rs stringForColumn:@"tnote"];
            etage.ttype = [rs stringForColumn:@"ttype"];
            [etype.tagArr addObject:etage];
        }
        [rs close];
    }
    
    [db close];
    return dataArray;
}

+ (NSMutableArray *)getAllTags;
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [SQLBaseManager checkTGTableCreatedInDb:db];
    
    NSString *selectStr = [NSString stringWithFormat:@"SELECT *  From 'Tags'"];
    
    FMResultSet *rs = [db executeQuery:selectStr];
    while ([rs next]) {
        EBTags *etage = [[EBTags alloc] init];
        etage.tid = [rs intForColumn:@"id"];
        etage.tname = [rs stringForColumn:@"tname"];
        etage.timage = [rs stringForColumn:@"timage"];
        etage.tnote = [rs stringForColumn:@"tnote"];
        etage.ttype = [rs stringForColumn:@"ttype"];
        [dataArray addObject:etage];
    }
    [rs close];
    return dataArray;

}

+ (NSMutableArray *)getTagsWithType:(BOOL)ttype;
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [SQLBaseManager checkTGTableCreatedInDb:db];
    
    NSString *typeStr = ttype?@"0":@"1";
    
    NSString *selectStr = [NSString stringWithFormat:@"SELECT *  From 'Tags' where ttype = '%@'",typeStr];
    
    FMResultSet *rs = [db executeQuery:selectStr];
    while ([rs next]) {
        EBTags *etage = [[EBTags alloc] init];
        etage.tid = [rs intForColumn:@"id"];
        etage.tname = [rs stringForColumn:@"tname"];
        etage.timage = [rs stringForColumn:@"timage"];
        etage.tnote = [rs stringForColumn:@"tnote"];
        etage.ttype = [rs stringForColumn:@"ttype"];
        [dataArray addObject:etage];
    }
    [rs close];
    return dataArray;
}

+ (EBTags *)getTagsWithTid:(NSString *)tid;
{
    EBTags *etage = [[EBTags alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    [SQLBaseManager checkTGTableCreatedInDb:db];
    
    NSString *selectStr = [NSString stringWithFormat:@"SELECT *  From 'Tags' where id = '%@'",tid];
    
    FMResultSet *rs = [db executeQuery:selectStr];
    while ([rs next]) {
        etage.tid = [rs intForColumn:@"id"];
        etage.tname = [rs stringForColumn:@"tname"];
        etage.timage = [rs stringForColumn:@"timage"];
        etage.tnote = [rs stringForColumn:@"tnote"];
        etage.ttype = [rs stringForColumn:@"ttype"];
    }
    [rs close];
    return etage;
}

+ (BOOL)insertTagModel:(EBTags *)model;
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [SQLBaseManager checkTGTableCreatedInDb:db];
    NSString *insertStr = @"INSERT INTO 'Tags' ('tname', 'timage' , 'tnote', 'ttype') VALUES (?,?,?,?)";
    BOOL worked = [db executeUpdate:insertStr, model.tname, model.timage, model.tnote,model.ttype];
    [db close];
    return worked;
}

+ (BOOL)deleteTagData:(EBTags *)model;
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [SQLBaseManager checkTGTableCreatedInDb:db];
    BOOL worked1 = [db executeUpdate:@"delete from 'Accounts' where tid = ?", @(model.tid)];
    BOOL worked = [db executeUpdate:@"delete from 'Tags' where id = ?", @(model.tid)];
    [db close];
    return (worked && worked1);
}

+ (BOOL)modifyTagData:(EBTags *)model;
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [SQLBaseManager checkTGTableCreatedInDb:db];
    NSString *sqlStr = [NSString stringWithFormat:@"update 'Tags' set  tname = '%@', timage = '%@', ttype = '%@', tnote = '%@' where id = %@", model.tname, model.timage ,model.ttype, model.tnote, [NSNumber numberWithInt:model.tid]];
    BOOL worked = [db executeUpdate:sqlStr];
    [db close];
    return worked;
}


// 创建标签表
+ (BOOL)checkTGTableCreatedInDb:(FMDatabase *)db {
    NSString *createStr = @"CREATE TABLE IF NOT EXISTS Tags(id INTEGER PRIMARY KEY, tname TEXT NOT NULL, timage TEXT NOT NULL, ttype TEXT NOT NULL, tnote TEXT NOT NULL);";
    BOOL worked = [db executeUpdate:createStr];
    //    FMDBQuickCheck(worked);
    return worked;
}
@end
