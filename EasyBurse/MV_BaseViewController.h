//
//  MV_BaseViewController.h
//  MyTreasure
//
//  Created by Bryan on 15/11/11.
//  Copyright © 2015年 makervt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKAlertView.h"
#import "EBViewController.h"
#import "HTKDragAndDropCollectionViewController.h"

//@class MV_NavigationViewController;

@interface MV_BaseViewController : HTKDragAndDropCollectionViewController

/**
 *  navigationController
 */
//@property (nonatomic, strong ,readonly) MV_NavigationViewController *navigationController;
/**
 *  title
 */

-(void)doInBackground:(void(^)(void))block;
-(void)doInMain:(void(^)(void))block;
-(void)doAsync:(void(^)(void))block completion:(void(^)(void))completion;


@end
