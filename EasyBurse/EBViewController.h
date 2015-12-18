//
//  EBViewController.h
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/4.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MV_TitleBar.h"

@interface EBViewController : UINavigationController<MV_TitleBarDelegate>

@property (nonatomic, strong) MV_TitleBar *titleBar;

@end
