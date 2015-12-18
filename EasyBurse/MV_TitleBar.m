//
//  MV_TitleBar.m
//  MyTreasure
//
//  Created by Bryan on 15/11/11.
//  Copyright © 2015年 makervt. All rights reserved.
//

#import "MV_TitleBar.h"

@implementation MV_TitleBar

- (id)initWithTitle:(NSString *)title leftButtonType:(MV_TitleBarButtonStyle)leftType rightButtonType:(MV_TitleBarButtonStyle)rightType {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    if (self) {
        self.backgroundColor = RGB(116, 207, 148); //e4007f 861414 a52a2a b22222 c40000
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowOpacity = 0.1;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, SCREEN_WIDTH-100, 44)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        titleLabel.textColor = UIColorFromRGB(0xffffff, 1.f);
        [self addSubview:titleLabel];
        
        [self setLeftButtonType:leftType];
        [self setRightButtonType:rightType];
    }
    return self;
}

- (void)setType:(MV_TitleBarStyle)type {
    _type = type;
    if (_type == MV_TitleBarStyle_Black) {
        self.backgroundColor = [UIColor colorWithRed:0x00 / 255.0f green:0x00 / 255.0f blue:0x00 / 255.0f alpha:0.4f];
        titleLabel.textColor = [UIColor whiteColor];
    }
}

- (void)setLeftButtonTitle:(NSString *)title {
    if (!leftButton) {
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 20, 60, 44);
        leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [leftButton addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
    }
    leftButton.hidden = NO;
    [self setButtonGrayTitle:title button:leftButton];
    leftButton.center = CGPointMake(30, 44);
}

- (void)setRightButtonTitle:(NSString *)title {
    if (!rightButton) {
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(SCREEN_WIDTH - 50, 20, 60, 44);
        rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [rightButton addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
    }
    rightButton.hidden = NO;
    [self setButtonGrayTitle:title button:rightButton];
    rightButton.center = CGPointMake(SCREEN_WIDTH - 50, 44);
}

- (void)setLeftButtonType:(MV_TitleBarButtonStyle)type {
    if (!leftButton) {
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 20, 60, 44);
        leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [leftButton addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
    }
    leftButton.hidden = NO;
    [self setButtonType:type button:leftButton];
    leftButton.center = CGPointMake(30, 44);
}

- (void)setRightButtonType:(MV_TitleBarButtonStyle)type {
    if (!rightButton) {
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(260, 20, 60, 44);
        rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [rightButton addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
    }
    rightButton.hidden = NO;
    [self setButtonType:type button:rightButton];
    rightButton.center = CGPointMake(SCREEN_WIDTH - 30, 44);
}

- (void)setButtonType:(MV_TitleBarButtonStyle)type button:(UIButton *)button {
    button.hidden = NO;
    switch (type) {
        case MV_TitleBarButtonStyle_None: {
            button.hidden = YES;
        }
            break;
        case MV_TitleBarButtonStyle_Back: {
            //titlebar-back-icon 原来的
            [button setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
            CGRect buttonFrame = button.frame;
            buttonFrame.size = CGSizeMake(44, 44);
            button.frame = buttonFrame;
        }
            break;
        case MV_TitleBarButtonStyle_Cancel: {
            [self setButtonGrayTitle:@"取消" button:button];
        }
            break;
        case MV_TitleBarButtonStyle_Register: {
            [self setButtonPinkTitle:@"注册" button:button];
        }
            break;
        case MV_TitleBarButtonStyle_Login: {
            [self setButtonPinkTitle:@"登录" button:button];
        }
            break;
        case MV_TitleBarButtonStyle_Send: {
            [self setButtonPinkTitle:@"发送" button:button];
        }
            break;
        case MV_TitleBarButtonStyle_Camera: {
            [button setImage:[UIImage imageNamed:@"titlebar-camera.png"] forState:UIControlStateNormal];
            CGRect buttonFrame = button.frame;
            buttonFrame.size = CGSizeMake(44, 44);
            button.frame = buttonFrame;
        }
            break;
        case MV_TitleBarButtonStyle_Add: {
            [button setImage:[UIImage imageNamed:@"titlebar-more.png"] forState:UIControlStateNormal];
            CGRect buttonFrame = button.frame;
            buttonFrame.size = CGSizeMake(44, 44);
            button.frame = buttonFrame;
        }
            break;
        case MV_TitleBarButtonStyle_WhiteBack: {
            [button setImage:[UIImage imageNamed:@"titlebar-back-white-common.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"titlebar-back-white-pressed.png"] forState:UIControlStateHighlighted];
            CGRect buttonFrame = button.frame;
            buttonFrame.size = CGSizeMake(44, 44);
            button.frame = buttonFrame;
        }
            break;
        case MV_TitleBarButtonStyle_WhiteMore: {
            [button setImage:[UIImage imageNamed:@"shezhi_white"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"shezhi_white"] forState:UIControlStateHighlighted];
            CGRect buttonFrame = button.frame;
            buttonFrame.size = CGSizeMake(44, 44);
            button.frame = buttonFrame;
        }
            break;
        case MV_TitleBarButtonStyle_Share: {
            [button setImage:[UIImage imageNamed:@"share_common"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"share_pressed"] forState:UIControlStateHighlighted];
            CGRect buttonFrame = button.frame;
            buttonFrame.size = CGSizeMake(44, 44);
            button.frame = buttonFrame;
        }
            break;
        case MV_TitleBarButtonStyle_Submit: {
            [self setButtonPinkTitle:@"提交" button:button];
        }
            break;
        case MV_TitleBarButtonStyle_More: {
            [button setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"more_p"] forState:UIControlStateHighlighted];
            CGRect buttonFrame = button.frame;
            buttonFrame.size = CGSizeMake(44, 44);
            button.frame = buttonFrame;
        }
            break;
        case MV_TitleBarButtonStyle_OK: {
            [self setButtonPinkTitle:@"确定" button:button];
        }
            break;
        case MV_TitleBarButtonStyle_Save: {
            [self setButtonPinkTitle:@"保存" button:button];
        }
            break;
        case MV_TitleBarButtonStyle_Settings: {
            [button setImage:[UIImage imageNamed:@"titlebar-set-common.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"titlebar-set-pressed.png"] forState:UIControlStateHighlighted];
            CGRect buttonFrame = button.frame;
            buttonFrame.size = CGSizeMake(44, 44);
            button.frame = buttonFrame;
        }
            break;
        default:
            break;
    }
}

- (void)setButtonPinkTitle:(NSString *)title button:(UIButton *)button {
    [button setTitleColor:[UIColor colorWithRed:0xff / 255.0f green:0x00 / 255.0f blue:0x51 / 255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    //    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}];
    //    CGRect buttonFrame = button.frame;
    //    buttonFrame.size = titleSize;
    //    button.frame = buttonFrame;
}

- (void)setButtonGrayTitle:(NSString *)title button:(UIButton *)button {
    [button setTitleColor:[UIColor colorWithRed:0x5d / 255.0f green:0x5d / 255.0f blue:0x5d / 255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}];
    CGRect buttonFrame = button.frame;
    buttonFrame.size = titleSize;
    button.frame = buttonFrame;
}

- (void)leftButtonTapped:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(titleBarLeftClick)]) {
        [self.delegate titleBarLeftClick];
    }
}

- (void)rightButtonTapped:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(titleBarRightClick)]) {
        [self.delegate titleBarRightClick];
    }
}

- (void)resetTitle:(NSString*)title {
    titleLabel.text = title;
}

@end
