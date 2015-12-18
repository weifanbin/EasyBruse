//
//  AddTagCell.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/7.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "AddTagCell.h"

@interface AddTagCell ()
@property (nonatomic, strong) UIImageView *typeImg;
@end

@implementation AddTagCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    
    self.typeImg = [UIImageView new];
    self.typeImg.image = [UIImage imageNamed:@"gongz"];
    [self.contentView addSubview:self.typeImg];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.typeImg.frame = rect(self.width / 2 - 18, 5, 110 / 3, 110 / 3);
}

- (void)setStr:(NSString *)str
{
    self.typeImg.image = [UIImage imageNamed:str];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = GreenColor;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
