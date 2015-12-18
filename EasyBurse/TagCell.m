//
//  TagCell.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/5.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "TagCell.h"

@interface TagCell ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *typeImg;
@property (nonatomic, strong) UILabel *detail;
@end

@implementation TagCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = BACKGROUND_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildSubviews];
    }
    return self;
}

-(void)buildSubviews
{
    self.name = [UILabel new];
    self.name.textColor = [UIColor blackColor];
    self.name.font = font(16);
    [self.contentView addSubview:self.name];
    
    self.detail = [UILabel new];
    self.detail.textColor = UIColorFromRGB(0x959595, 1.0);
    self.detail.font = font(14);
    [self.contentView addSubview:self.detail];
    
    
    self.typeImg = [UIImageView new];
    self.typeImg.image = [UIImage imageNamed:@"gongz"];
    [self.contentView addSubview:self.typeImg];
    
    UIView *line = [UIView new];
    line.backgroundColor = GreenColor;
    line.layer.cornerRadius = 2;
    line.clipsToBounds = YES;
    line.frame = CGRectMake(50, 10, 1, self.height - 20);
    [self.contentView addSubview:line];
    
    UIImageView *arrow = [UIImageView new];
    arrow.image = [UIImage imageNamed:@"right_press"];
    arrow.frame = CGRectMake(SCREEN_WIDTH - 20, 15, 26 / 3, 51 / 3);
    [self.contentView addSubview:arrow];
    
    UIView *topline = [UIView new];
    topline.backgroundColor = GreenColor;
    topline.layer.cornerRadius = 2;
    topline.clipsToBounds = YES;
    topline.frame = CGRectMake(10 , 0, SCREEN_WIDTH - 10, 0.5);
    [self.contentView addSubview:topline];
    
    UIView *bottomline = [UIView new];
    bottomline.backgroundColor = GreenColor;
    bottomline.layer.cornerRadius = 2;
    bottomline.clipsToBounds = YES;
    bottomline.frame = CGRectMake(10 , self.height - 0.5, SCREEN_WIDTH - 10, 0.5);
    [self.contentView addSubview:bottomline];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.typeImg.frame = rect(10, 5, 110 / 3, 110 / 3);
    self.name.frame = rect(self.typeImg.right + 15, 13, 210, 20);
    self.detail.frame = rect(120, 13, SCREEN_WIDTH - 140, 20);
}

-(void)setTag:(EBTags *)tag
{
    self.name.text = tag.tname;
    self.typeImg.image = [UIImage imageNamed:tag.timage];
    self.detail.text = tag.tnote;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
