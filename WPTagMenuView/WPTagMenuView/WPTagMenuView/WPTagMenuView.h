//
//  WPTagMenuView.h
//  WPTagMenuView
//
//  Created by WP on 16/2/2.
//  Copyright © 2016年 mango. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width) // 获取屏幕宽度
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height) // 获取屏幕高度

@class  WPTagMenuView;
@protocol  WPTagMenuViewDataSource<NSObject>
/** 一共几个可以点击区域 */
- (NSInteger)numberOfSectionsInTagMenu:(WPTagMenuView *)tagMenu ;
/** 每一个section 的tag 值 */
- (NSArray<NSString *> *)tagMenu:(WPTagMenuView *)tagMenu tagsForSectionIndex:(NSInteger)index;

- (void)tagMenu:(WPTagMenuView *)tagMenu didSelectTagAtSection:(NSInteger)section tagIndex:(NSInteger)index;

@required
/**header title */
- (NSString *)tagMenu:(WPTagMenuView *)tagMenu titleForHeaderInSection:(NSInteger)section;


@end

@interface WPTagMenuView : UIView

@property (nonatomic, weak)id <WPTagMenuViewDataSource> dataSource;

@property (nonatomic, assign,readonly) BOOL isShow;
/** 显示 */
- (void)showTagMenuAtSuperView:(UIView *)superView;
/** 隐藏 */
- (void)dismissTagMenu;
/** 重置  取消所有选择*/
- (void)resetTagMenu;

@end
