//
//  WPTag.h
//  askLocal
//
//  Created by WP on 15/12/1.
//  Copyright © 2015年 xianlvke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WPTag : NSObject

/** tag 的内容 */
@property (copy, nonatomic, nullable) NSString *text;
/** tag 的有属性内容 */
@property (copy, nonatomic, nullable) NSAttributedString *attributedText;
/** 文字颜色 */
@property (strong, nonatomic, nullable) UIColor *textColor;
/** 选中的文字颜色 */
@property (strong ,nonatomic, nullable) UIColor *selectedTextColor;
/** 背景色 */
@property (strong, nonatomic, nullable) UIColor *bgColor;
/** 背景图 */
@property (strong, nonatomic, nullable) UIImage *bgImg;
/** 选中的背景图 */
@property (strong, nonatomic, nullable) UIImage *selectedBgImg;
/** 倒角 default 5 */
@property (assign, nonatomic) CGFloat cornerRadius;
/** tag边的颜色 */
@property (strong, nonatomic, nullable) UIColor *borderColor;
/** tag边的宽度 default 1*/
@property (assign, nonatomic) CGFloat borderWidth;
/** tag中text的内边距 */
@property (assign, nonatomic) UIEdgeInsets padding;
/** text 的字体  */
@property (strong, nonatomic, nullable) UIFont *font;
//if no font is specified, system font with fontSize is used
@property (assign, nonatomic) CGFloat fontSize;
/** 是否可以交互  default Yes */
@property (assign, nonatomic) BOOL enable;
/** 被选中 */
@property (assign, nonatomic) BOOL selected;

- (instancetype)initWithText:( NSString * _Nullable)text;
+ (instancetype)tagWithText:(NSString * _Nullable)text;
@end
