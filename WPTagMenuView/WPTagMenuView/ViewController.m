//
//  ViewController.m
//  WPTagMenuView
//
//  Created by WP on 16/2/3.
//  Copyright © 2016年 xianlvke. All rights reserved.
//

#import "ViewController.h"
#import "WPTagMenuView.h"
@interface ViewController ()<WPTagMenuViewDataSource>

@property (nonatomic, strong)NSMutableArray *dateSource;
@property (nonatomic, strong)NSArray *titles;

@property (nonatomic, strong) WPTagMenuView *tagMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateSource = [NSMutableArray array];
    [self.dateSource addObject:@[@"东",@"南", @"西", @"北", @"西南" ]];
    [self.dateSource addObject:@[
                                @"学区房",
                                @"地铁房",
                                @"不限购",
                                @"满两年",
                                @"降价",
                                @"满五唯一",
                                @"新上",
                                @"独家",
                                @"有钥匙"
                                ]];
    [self.dateSource addObject:@[ @"5年以内", @"10年以内", @"10 - 20年", @"20年以上" ]];
    [self.dateSource addObject:@[ @"底层楼", @"中层楼", @"高层楼" ]];
    
    self.titles = @[@"方位",@"标签",@"年限",@"楼层"];
    
    
    self.tagMenu = [[WPTagMenuView alloc]init];
    self.tagMenu.dataSource = self;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTagView:(UIButton *)sender {
    if (self.tagMenu.isShow) {
        [self.tagMenu dismissTagMenu];
    } else {
        
        [self.tagMenu showTagMenuAtSuperView:sender];
    }
    
    
}

#pragma mark - tagMenuDataSource

- (NSInteger)numberOfSectionsInTagMenu:(WPTagMenuView *)tagMenu {
    return self.dateSource.count;

}

- (NSArray<NSString *> *)tagMenu:(WPTagMenuView *)tagMenu tagsForSectionIndex:(NSInteger)section {

    return self.dateSource[section];

}

- (void)tagMenu:(WPTagMenuView *)tagMenu didSelectTagAtSection:(NSInteger)section tagIndex:(NSInteger)index {
    NSLog(@"%lu, %lu",section, index);
    
}

- (NSString *)tagMenu:(WPTagMenuView *)tagMenu titleForHeaderInSection:(NSInteger)section {

   return  self.titles[section];
    
}


// 点击  重置
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tagMenu resetTagMenu];
    
}




@end
