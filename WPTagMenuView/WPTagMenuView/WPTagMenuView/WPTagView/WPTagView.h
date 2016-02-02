//
//  WPTagView.h
//  askLocal
//
//  Created by WP on 15/12/1.
//  Copyright © 2015年 xianlvke. All rights reserved.
/**
 */

#import <UIKit/UIKit.h>
#import "WPTag.h"

@interface WPTagView : UIView
/** tag 内容view 的内边距 default  UIEdgeInsetsMake(12, 12, 12, 12); */
@property (nonatomic) UIEdgeInsets padding;
/** 每一行之间的高度 default 10 */
@property (nonatomic) int lineSpace;
/** tag 之间的边距 default 10*/
@property (nonatomic) CGFloat interitemSpacing;
/** 允许的最大宽度 */
@property (nonatomic) CGFloat preferredMaxLayoutWidth;
/** 只展示成一行  default is NO */
@property (nonatomic) BOOL singleLine;

/** 单选 或 多选  default  YES 单选 */
@property (nonatomic)BOOL isSingleSelect;

- (void)addTag:(WPTag *)tag;
- (void)insertTag:(WPTag *)tag atIndex:(NSUInteger)index;
- (void)removeTag:(WPTag *)tag;
- (void)removeTagAtIndex:(NSUInteger)index;
- (void)removeAllTags;
- (NSString *)selectedTagsString;
@property (nonatomic, copy) void (^didClickTagAtIndex)(NSInteger index);

@end
