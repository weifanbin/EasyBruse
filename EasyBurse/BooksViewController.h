//
//  BooksViewController.h
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "ViewController.h"
#import "MV_BaseViewController.h"

//@protocol BooksViewControllerDelegate <NSObject>
//
//@optional
//- (void)refreshData:(NSMutableArray *)selectArray;
//
//@end

typedef void(^RefreshTableView)(NSMutableArray* selectArray);

@interface BooksViewController : MV_BaseViewController

@end
