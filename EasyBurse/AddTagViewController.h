//
//  AddTagViewController.h
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/7.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "MV_BaseViewController.h"
#import "EBTags.h"

@interface AddTagViewController : MV_BaseViewController<MV_TitleBarDelegate>
-(void)initData:(EBTags *)eTage;
@end
