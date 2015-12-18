//
//  BooksCell.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/3.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "BooksCell.h"
#import "SQLBaseManager.h"

@interface BooksCell ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIImageView *typeImg;
@property (nonatomic, strong) UILabel *detail;
@end

@implementation BooksCell

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
    self.name.font = font(14);
    [self.contentView addSubview:self.name];
    
    self.detail = [UILabel new];
    self.detail.textColor = UIColorFromRGB(0x959595, 1.0);
    self.detail.font = font(10);
    [self.contentView addSubview:self.detail];
    
    self.time = [UILabel new];
    self.time.textColor = UIColorFromRGB(0x959595, 1.0);
    self.time.font = font(12);
    [self.contentView addSubview:self.time];
    
    self.price = [UILabel new];
    self.price.textColor = UIColorFromRGB(0x959595, 1.0);
    self.price.textAlignment = NSTextAlignmentRight;
    self.price.font = font(16);
    [self.contentView addSubview:self.price];
    
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
    self.name.frame = rect(self.typeImg.right + 15, self.height/2-20, 60, 20);
    self.detail.frame = rect(self.name.right, 5, 150, 20);
    self.time.frame = rect(self.typeImg.right + 15, self.height/2, 210, 20);
    self.price.frame = rect(SCREEN_WIDTH - 230, self.height/2-12.5, 200, 25);
}

-(void)setAccount:(Accounts *)account
{
    EBTags *tags = [SQLBaseManager getTagsWithTid:account.tid];
    NSString *tagImg = tags.timage;
    self.name.text = tags.tname;
    self.detail.text = account.content;
    
    self.typeImg.image = [UIImage imageNamed:tagImg];
    
    
    NSString *typeStr = [account.type intValue] == 0?@"支出":@"收入";
    
    self.time.text = [NSString stringWithFormat:@"%@ %@",typeStr,account.time];
    
    
    if ([account.type intValue] == 0)
    {
        self.price.textColor = RedColor;
        self.price.text = [NSString stringWithFormat:@"￥%@",account.payprice];
    }
    else
    {
        self.price.textColor = GreenColor;
        self.price.text = [NSString stringWithFormat:@"￥%@",account.inprice];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
