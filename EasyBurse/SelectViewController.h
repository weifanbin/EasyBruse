//
//  SelectViewController.h
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/7.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "MV_BaseViewController.h"
#import "BooksViewController.h"

@interface SelectViewController : MV_BaseViewController<MV_TitleBarDelegate>

//@property (nonatomic,weak) id <BooksViewControllerDelegate> bookDelegate;

@property (nonatomic, copy) RefreshTableView rf;
@end
