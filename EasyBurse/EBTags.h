//
//  EBTags.h
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/5.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBTagType : NSObject
@property (nonatomic,retain) NSString *ttype;
@property (nonatomic,retain) NSMutableArray *tagArr;
@end


@interface EBTags : NSObject

@property (nonatomic) int tid;
@property (nonatomic,retain) NSString *tname;
@property (nonatomic,retain) NSString *timage;
@property (nonatomic,retain) NSString *ttype;
@property (nonatomic,retain) NSString *tnote;   // 备注
@property (nonatomic) int tindex;  // 索引
@end
