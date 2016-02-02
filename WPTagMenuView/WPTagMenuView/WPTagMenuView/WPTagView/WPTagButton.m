
//
//  WPTagButton.m
//  askLocal
//
//  Created by WP on 15/12/1.
//  Copyright © 2015年 xianlvke. All rights reserved.
//

#import "WPTagButton.h"
#import "WPTag.h"

@implementation WPTagButton

+ (instancetype)buttonWithTag:(WPTag *)tag
{
    WPTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (tag.attributedText) {
        [btn setAttributedTitle:tag.attributedText forState:UIControlStateNormal];
    } else {
        [btn setTitle:tag.text forState:UIControlStateNormal];
        [btn setTitleColor:tag.textColor forState:UIControlStateNormal];
        [btn setTitleColor:tag.selectedTextColor forState:UIControlStateSelected];
        btn.titleLabel.font = tag.font ?: [UIFont systemFontOfSize:tag.fontSize];
    }
    
    btn.backgroundColor = tag.bgColor;
    btn.contentEdgeInsets = tag.padding;
    btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if (tag.bgImg)
    {
        [btn setBackgroundImage:tag.bgImg forState:UIControlStateNormal];
    }
    
    if (tag.selectedBgImg) {
        [btn setBackgroundImage:tag.selectedBgImg forState:UIControlStateSelected];
    }
    
    if (tag.borderColor)
    {
        btn.layer.borderColor = tag.borderColor.CGColor;
    }

    
    if (tag.borderWidth)
    {
        btn.layer.borderWidth = tag.borderWidth;
    }
    
    btn.userInteractionEnabled = tag.enable;
    btn.selected  = tag.selected;
    
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
    
    return btn;
}


@end
