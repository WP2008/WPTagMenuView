//
//  WPSelectTagMenuView.m
//  封装
//
//  Created by WP on 16/2/2.
//  Copyright © 2016年 mango. All rights reserved.
//

#import "WPTagMenuView.h"
#import "Masonry.h"
#import "WPTagView.h"

/**
 *  -------------- WPSelectTagCell --------------
 */
static CGFloat const kWPSelectTagCellDefaultHeight = 48.0;
typedef void(^WPSelectedTagBlock)(NSInteger index);

@interface WPSelectTagCell : UITableViewCell
/** 要显示的tag */
@property (nonatomic, strong)NSArray<NSString *> *tags;
/** 选中的tag */
@property (nonatomic, copy)WPSelectedTagBlock block;
/** cell 高度 */
@property (nonatomic, assign)NSInteger cellHeight;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

@interface WPSelectTagCell()
@property (nonatomic, weak) WPTagView *tagView;

@end

@implementation WPSelectTagCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"caonimaIdentifier";
    WPSelectTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if ( cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (WPTagView *)tagView {
    if (_tagView == nil) {
        WPTagView *tagView = [[WPTagView alloc]init];
        [self.contentView addSubview:tagView];
        _tagView = tagView;
        _tagView.preferredMaxLayoutWidth = kScreenWidth;
        _tagView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
        _tagView.lineSpace = 10;
        _tagView.interitemSpacing = 10;
        _tagView.didClickTagAtIndex = ^(NSInteger index){


            if (self.block) {
                
                self.block(index);
                
            }
            
        };
        
        
        [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
    }
    return _tagView;
}


- (void)setTags:(NSArray<NSString *> *)tags {
    if (tags == nil || (tags == _tags)) {
        return;
    }
    
    [self.tagView removeAllTags];
     _tags = tags;
 
    [_tags enumerateObjectsUsingBlock:^(NSString *str , NSUInteger idx, BOOL * _Nonnull stop) {
        WPTag *tag = [WPTag tagWithText:str];
        tag.font = [UIFont systemFontOfSize:14];
        tag.bgColor = [UIColor lightGrayColor];
        tag.borderColor = [UIColor grayColor];
        tag.borderWidth = 1.0;
        tag.cornerRadius = 5.0;
        tag.padding = UIEdgeInsetsMake(8, 12, 8, 12);
        tag.enable = YES;
        [self.tagView addTag:tag];
        
    }];
    
    self.cellHeight = _tags.count ?
    self.tagView.intrinsicContentSize.height : kWPSelectTagCellDefaultHeight;
}




@end




/**
 *  -------------- WPSelectTagMenuView --------------
 */


@interface WPTagMenuView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

//@property (nonatomic, weak) UIButton *resetBtn;
//@property (nonatomic, weak) UIButton *confirmBtn;

@end
@implementation WPTagMenuView

#pragma mark - lifeCycle

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}


- (void)configSubViews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsZero);
    }];
//    
//    [self resetBtn];
//    [self confirmBtn];
    

}


#pragma mark - getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:tableView];
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionHeaderHeight = 30;
        _tableView.sectionFooterHeight = 0;
    }

    return _tableView;
}

//- (UIButton *)resetBtn {
//    if (_resetBtn == nil) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [self addSubview:btn];
//        _resetBtn = btn;
//        [_resetBtn addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
//        _resetBtn.layer.cornerRadius = 5;
//        _resetBtn.layer.masksToBounds = YES;
//        _resetBtn.layer.borderWidth = 2;
//        _resetBtn.frame = CGRectMake(20, self.frame.size.height - 35, 80, 30);
//        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
//    }
//    return _resetBtn;
//}
//
//- (UIButton *)confirmBtn {
//    if (_confirmBtn == nil) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [self addSubview:btn];
//        _confirmBtn = btn;
//        [_confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
//        _confirmBtn.layer.cornerRadius = 5;
//        _confirmBtn.layer.masksToBounds = YES;
//        _confirmBtn.layer.borderWidth = 2;
//        _confirmBtn.frame = CGRectMake(150, self.frame.size.height - 35, 80, 30);
//        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
//    }
//    return _confirmBtn;
//}
//
//- (void)reset:(UIButton *)btn {
//
//
//}
//
//- (void)confirm:(UIButton *)btn {
//
//
//}

#pragma mark - tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return [self.dataSource numberOfSectionsInTagMenu:self];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WPSelectTagCell *cell = [WPSelectTagCell cellWithTableView:tableView];
    cell.tags = [self.dataSource tagMenu:self tagsForSectionIndex:indexPath.section];
    cell.block = ^(NSInteger index) {
    
        [self.dataSource tagMenu:self didSelectTagAtSection:indexPath.section tagIndex:index];
        
    };
    
    return cell;;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WPSelectTagCell *cell = [WPSelectTagCell cellWithTableView:tableView];
    cell.tags = [self.dataSource tagMenu:self tagsForSectionIndex:indexPath.section];
    return cell.cellHeight;;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(tagMenu:titleForHeaderInSection:)]) {
        return [self.dataSource tagMenu:self titleForHeaderInSection:section];
    } else {
       return nil;
    }
 
}



#pragma mark - public 
- (void)showTagMenuAtSuperView:(UIView *)superView; {
    if (self.isShow) {
        return;
    }
    
    CGRect showFrame = superView.frame;
    CGFloat x = 0.f;
    CGFloat y = showFrame.origin.y + showFrame.size.height;
    CGFloat w = kScreenWidth;
    CGFloat h = kScreenHeight - y;
    self.frame = CGRectMake(x, y, w, h);
    // 如果没有superView
    if(!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        self.alpha = .0f;
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
        }];
    }
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
    
     _isShow = YES;
    
}

- (void)dismissTagMenu {
    
    if(self.superview) {
        _isShow = NO;
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
        } completion:^(BOOL finished) {
    
            [self removeFromSuperview];
            
        }];
    }

}

- (void)resetTagMenu {
    
    [self.tableView reloadData];


}


@end


