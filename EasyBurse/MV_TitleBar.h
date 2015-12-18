//
//  MV_TitleBar.h
//  MyTreasure
//
//  Created by Bryan on 15/11/11.
//  Copyright © 2015年 makervt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MV_TitleBarDelegate <NSObject>

@optional
- (void)titleBarLeftClick;
- (void)titleBarRightClick;

@end

typedef NS_ENUM(NSUInteger, MV_TitleBarButtonStyle) {
    MV_TitleBarButtonStyle_None = 0,
    MV_TitleBarButtonStyle_Back,
    MV_TitleBarButtonStyle_Cancel,
    MV_TitleBarButtonStyle_Register,
    MV_TitleBarButtonStyle_Login,
    MV_TitleBarButtonStyle_Send,
    MV_TitleBarButtonStyle_Camera,
    MV_TitleBarButtonStyle_Add,
    MV_TitleBarButtonStyle_Friend,
    MV_TitleBarButtonStyle_Upload,
    MV_TitleBarButtonStyle_WhiteBack,
    MV_TitleBarButtonStyle_WhiteMore,
    MV_TitleBarButtonStyle_OK,
    MV_TitleBarButtonStyle_More,
    MV_TitleBarButtonStyle_Share,
    MV_TitleBarButtonStyle_WhiteShare,
    MV_TitleBarButtonStyle_Submit,
    MV_TitleBarButtonStyle_Save,
    MV_TitleBarButtonStyle_Settings
};

typedef NS_ENUM(NSUInteger, MV_TitleBarStyle) {
    MV_TitleBarStyle_Default = 0,
    MV_TitleBarStyle_Black,
    //    MV_TitleBarButtonStyle_Add,
    //    MV_TitleBarButtonStyle_Share,
    //    MV_TitleBarButtonStyle_Submit,
    //    MV_TitleBarButtonStyle_More,
    //    MV_TitleBarButtonStyle_OK,
    //    MV_TitleBarButtonStyle_Create,
    //    MV_TitleBarButtonStyle_Upload
};

@interface MV_TitleBar : UIView
{
    UILabel *titleLabel;
    UIButton *leftButton;
    UIButton *rightButton;
}

@property (nonatomic, assign) id<MV_TitleBarDelegate> delegate;
@property (nonatomic, assign) MV_TitleBarStyle type;

- (id)initWithTitle:(NSString *)title leftButtonType:(MV_TitleBarButtonStyle)leftType rightButtonType:(MV_TitleBarButtonStyle)rightType;
- (void)setLeftButtonTitle:(NSString *)title;
- (void)setRightButtonTitle:(NSString *)title;
- (void)setLeftButtonType:(MV_TitleBarButtonStyle)type;
- (void)setRightButtonType:(MV_TitleBarButtonStyle)type;
- (void)resetTitle:(NSString*)title;


@end
