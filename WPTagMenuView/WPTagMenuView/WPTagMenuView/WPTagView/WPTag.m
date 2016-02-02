//
//  WPTag.m
//  askLocal
//
//  Created by WP on 15/12/1.
//  Copyright © 2015年 xianlvke. All rights reserved.
//

#import "WPTag.h"

static const CGFloat kDefaultFontSize = 14.0;


@implementation WPTag


- (instancetype)init {
    self = [super init];
    if (self) {
        _fontSize = kDefaultFontSize;
        _textColor = [UIColor colorWithWhite:0.325 alpha:1.000];
        _selectedTextColor = [UIColor whiteColor];
        _bgColor = [UIColor colorWithWhite:0.925 alpha:1.000];
        _borderColor = [UIColor colorWithWhite:0.599 alpha:0.815];
        _borderWidth = 1;
        _cornerRadius = 8;
        _padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
        _enable = YES;
    }
    return self;
}


- (instancetype)initWithText:(NSString *)text
{
    self = [self init];
    if (self)
    {
        _text = text;

    }
    
    return self;
}

+ (instancetype)tagWithText:(NSString *)text
{
    return [[self alloc] initWithText:text];
}

@end
