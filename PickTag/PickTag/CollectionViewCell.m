//
//  CollectionViewCell.m
//  CollectionViewSubscriptionLabel
//
//  Created by chenyk on 15/4/24.
//  Copyright (c) 2015年 chenyk. All rights reserved.
//

#import "CollectionViewCell.h"
#import "ColorUtil.h"

@implementation CollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setup];
    }
    return self;
}

- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}
- (id)sharedInit {
    [self setup];
    return self;
}

- (void)setup {
    self.titleLabel = [UILabel new];
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.titleLabel.layer.cornerRadius = 5.0;
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.textColor = UICOLOR_HEX(0xE54D42);
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.borderColor = UICOLOR_HEX(0xE54D42).CGColor;
    self.titleLabel.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)resetStyle {
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.textColor = UICOLOR_HEX(0xE54D42);
}

- (void)select {
    self.titleLabel.backgroundColor = UICOLOR_RGB(226, 89, 72, 1);
    self.titleLabel.textColor = [UIColor whiteColor];
}

- (void)unselect {
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.textColor = UICOLOR_HEX(0xE54D42);
}
@end
