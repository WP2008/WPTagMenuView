//
//  WPTagView.m
//  askLocal
//
//  Created by WP on 15/12/1.
//  Copyright © 2015年 xianlvke. All rights reserved.
//

#import "WPTagView.h"
#import "WPTagButton.h"
#import "Masonry.h"

#define SAVE_C(c) [self.tagsContraints addObject:c]

@interface WPTagView ()
@property (nonatomic, strong) NSMutableArray *tagsConstraints;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *selectedTags;

@property (nonatomic, weak) WPTagButton *lastSelected;

@property (nonatomic) BOOL didSetup;
@end

@implementation WPTagView

#pragma mark - Life circle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefauleValue];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefauleValue];

    }
    return self;
}

- (void)setDefauleValue {
    _padding   = UIEdgeInsetsMake(15, 15, 15, 15);
    _interitemSpacing   = 10;
    _lineSpace = 10;
    _singleLine = NO;
    _isSingleSelect = YES;
}

- (void)updateConstraints
{
    [self updateWrappingConstrains];
    [super updateConstraints];
}

-(CGSize)intrinsicContentSize
{
    if (!self.tags.count)
    {
        return CGSizeZero;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previewsView = nil;
    CGFloat leftOffset = self.padding.left;
    CGFloat bottomOffset = self.padding.bottom;
    CGFloat rightOffset = self.padding.right;
    CGFloat itemMargin = self.interitemSpacing;
    CGFloat topPadding = self.padding.top;
    CGFloat itemVerticalMargin = self.lineSpace;
    CGFloat currentX = leftOffset;
    CGFloat intrinsicHeight = topPadding;
    CGFloat intrinsicWidth = leftOffset;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0)
    {
        NSInteger lineCount = 0;
        for (UIView *view in subviews)
        {
            CGSize size = view.intrinsicContentSize;
            if (previewsView)
            {
                CGFloat width = size.width;
                currentX += itemMargin;
                if (currentX + width + rightOffset <= self.preferredMaxLayoutWidth)
                {
                    currentX += size.width;
                }
                else
                {
                    //New line
                    lineCount ++;
                    
                    currentX = leftOffset + size.width;
                    intrinsicHeight += size.height;
                    
                }
            }
            else
            {
                //First one
                lineCount ++;
                
                intrinsicHeight += size.height;
                currentX += size.width;
            }
            previewsView = view;
            intrinsicWidth = MAX(intrinsicWidth, currentX + rightOffset);
        }
        
        intrinsicHeight += bottomOffset + itemVerticalMargin * (lineCount - 1);
    }
    else
    {
        for (UIView *view in subviews)
        {
            CGSize size = view.intrinsicContentSize;
            intrinsicWidth += size.width;
        }
        intrinsicWidth += itemMargin * (subviews.count - 1) + rightOffset;
        intrinsicHeight += ((UIView *)subviews.firstObject).intrinsicContentSize.height + bottomOffset;
    }
    
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (void)layoutSubviews
{
    if (!self.singleLine) {
        self.preferredMaxLayoutWidth = self.frame.size.width;
    }
    
    [super layoutSubviews];
}

#pragma mark - Private methods 约束
-(void)updateWrappingConstrains
{
    if (self.didSetup || !self.tags.count)
    {
        return;
    }
    
    //Remove old constraints
    for (id obj in self.tagsConstraints)
    {
        if([obj isKindOfClass:MASConstraint.class])
        {
            [(MASConstraint *)obj uninstall];
        }
        else if([obj isKindOfClass:NSArray.class])
        {
            for (MASConstraint * constraint in (NSArray *)obj)
            {
                [constraint uninstall];
            }
        }
        else
        {
            NSAssert(NO, @"Error:unknown class type: %@",obj);
        }
    }
    [self.tagsConstraints removeAllObjects];
    
    
    
    //Install new constraints
    NSArray *subviews = self.subviews;
    UIView *previewsView = nil;
    UIView *superView = self;
    CGFloat leftOffset = self.padding.left;
    CGFloat bottomOffset = self.padding.bottom;
    CGFloat rightOffset = self.padding.right;
    CGFloat itemMargin = self.interitemSpacing;
    CGFloat topPadding = self.padding.top;
    CGFloat itemVerticalMargin = self.lineSpace;
    CGFloat currentX = leftOffset;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0)
    {
        for (UIView *view in subviews)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 SAVE_C(make.trailing.lessThanOrEqualTo(superView).with.offset(-rightOffset));
             }];
            
            CGSize size = view.intrinsicContentSize;
            if (previewsView)
            {
                CGFloat width = size.width;
                currentX += itemMargin;
                if (currentX + width + rightOffset <= self.preferredMaxLayoutWidth)
                {
                    [view mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         SAVE_C(make.leading.equalTo(previewsView.mas_trailing).with.offset(itemMargin));
                         SAVE_C(make.centerY.equalTo(previewsView.mas_centerY));
                     }];
                    currentX += size.width;
                }
                else
                {
                    //new line
                    [view mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         SAVE_C(make.top.greaterThanOrEqualTo(previewsView.mas_bottom).with.offset(itemVerticalMargin));
                         SAVE_C(make.leading.equalTo(superView.mas_leading).with.offset(leftOffset));
                     }];
                    currentX = leftOffset + size.width;
                }
            }
            else
            {
                //first one
                [view mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     SAVE_C(make.top.equalTo(superView.mas_top).with.offset(topPadding));
                     SAVE_C(make.leading.equalTo(superView.mas_leading).with.offset(leftOffset));
                 }];
                currentX += size.width;
            }
            
            previewsView = view;
        }
    }
    else
    {
        for (UIView *view in subviews)
        {
            CGSize size = view.intrinsicContentSize;
            if (previewsView)
            {
                [view mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     SAVE_C(make.leading.equalTo(previewsView.mas_trailing).with.offset(itemMargin));
                     SAVE_C(make.centerY.equalTo(previewsView.mas_centerY));
                 }];
                currentX += size.width;
            }
            else
            {
                //first one
                [view mas_makeConstraints:^(MASConstraintMaker *make)
                 {
                     SAVE_C(make.top.equalTo(superView.mas_top).with.offset(topPadding));
                     SAVE_C(make.leading.equalTo(superView.mas_leading).with.offset(leftOffset));
                 }];
                currentX += size.width;
            }
            
            previewsView = view;
        }
    }
    
    [previewsView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         SAVE_C(make.bottom.equalTo(superView.mas_bottom).with.offset(-bottomOffset));
     }];
    
    self.didSetup = YES;
}

#pragma mark - getter

- (NSMutableArray *)tags
{
    if(!_tags)
    {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (NSMutableArray *)tagsContraints
{
    if(!_tagsConstraints)
    {
        _tagsConstraints = [NSMutableArray array];
    }
    return _tagsConstraints;
}

- (NSMutableArray *)selectedTags
{
    if(!_selectedTags)
    {
        _selectedTags = [NSMutableArray array];
    }
    return _selectedTags;
}


- (void)setPreferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth
{
    if (preferredMaxLayoutWidth != _preferredMaxLayoutWidth) {
        _didSetup = NO;
        _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
        [self setNeedsUpdateConstraints];
    }
}


- (void)onTag:(WPTagButton *)btn
{
    btn.selected = !btn.selected;
    NSUInteger index = [self.subviews indexOfObject:btn];
    if (_isSingleSelect) {
        // 处理上一次选中
        if (btn.isSelected && (btn != self.lastSelected)) {
            self.lastSelected.selected = NO;
            self.lastSelected = btn;
        }
        
        
    } else {
    
        if (btn.isSelected) {
            [self.selectedTags addObject:self.tags[index]];
        } else {
            [self.selectedTags removeObject:self.tags[index]];
        }
        
    }
    
    
    
    if (self.didClickTagAtIndex)
    {
        self.didClickTagAtIndex(index);
    }
}


#pragma mark - Public methods

- (void)addTag:(WPTag *)tag
{
    WPTagButton *btn = [WPTagButton buttonWithTag:tag];
    [btn addTarget:self action:@selector(onTag:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.tags addObject:tag];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)insertTag:(WPTag *)tag atIndex:(NSUInteger)index
{
    if (index + 1 > self.tags.count)
    {
        [self addTag:tag];
    }
    else
    {
        WPTagButton *btn = [WPTagButton buttonWithTag:tag];
        [btn addTarget:self action:@selector(onTag:) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:btn atIndex:index];
        [self.tags insertObject:tag atIndex:index];
        
        self.didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)removeTag:(WPTag *)tag
{
    NSUInteger index = [self.tags indexOfObject:tag];
    if (NSNotFound == index)
    {
        return;
    }
    
    [self.tags removeObjectAtIndex:index];
    [self.subviews[index] removeFromSuperview];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeTagAtIndex:(NSUInteger)index
{
    if (index + 1 > self.tags.count)
    {
        return;
    }
    
    [self.tags removeObjectAtIndex:index];
    [self.subviews[index] removeFromSuperview];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeAllTags
{
    [self.tags removeAllObjects];
    [self.selectedTags removeAllObjects];
    for (UIView *v in self.subviews)
    {
        [v removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (NSString *)selectedTagsString {
    NSMutableString *tagsString = [NSMutableString string];
    
    [self.selectedTags enumerateObjectsUsingBlock:^(WPTag *tag, NSUInteger idx, BOOL * _Nonnull stop) {
        [tagsString appendFormat:@"%@,",tag.text];
    }];
    
    return [tagsString copy];
}

@end
