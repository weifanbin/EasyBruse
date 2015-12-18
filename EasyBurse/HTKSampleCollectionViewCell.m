//
//  HTKSampleCollectionViewCell.m
//  HTKDragAndDropCollectionView
//
//  Created by Henry T Kirk on 11/9/14.
//  Copyright (c) 2014 Henry T. Kirk (http://www.henrytkirk.info)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
#import "HTKSampleCollectionViewCell.h"

@interface HTKSampleCollectionViewCell ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *typeImg;
@end



@implementation HTKSampleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    
    // Create random background color
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *randomColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    //self.backgroundColor = randomColor;

    // create label
//    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    self.numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.numberLabel.textAlignment = NSTextAlignmentCenter;
//    self.numberLabel.textColor = [UIColor whiteColor];
//    self.numberLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
//    [self.contentView addSubview:self.numberLabel];
    
    self.name = [UILabel new];
    self.name.font = font(14);
    self.name.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.name];
    
    self.typeImg = [UIImageView new];
    self.typeImg.image = [UIImage imageNamed:@"gongz"];
    [self.contentView addSubview:self.typeImg];
    
    // Constrain it
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_name]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_name)]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_name]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_name)]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.typeImg.frame = rect(self.width / 2 - 18, 0, 110 / 3, 110 / 3);
    self.name.frame = rect(self.typeImg.left - 8, self.typeImg.bottom + 5, 50, 20);
}

- (void)setETags:(EBTags *)eTags
{
    self.name.text = eTags.tname;
    self.typeImg.image = [UIImage imageNamed:eTags.timage];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.name.textColor = [UIColor whiteColor];
        self.backgroundColor = GreenColor;
    }
    else
    {
        self.name.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
    }
}
@end
