# WPTagMenuView
tableView 的 cell 中 为可选标签  支持单选／多选 ／重置 ／自动布局 

tag  tagView 的样式更改没有暴露  
您可以在WPTag创建时  添加 normal 和 selected 的图片，设置 EdgeInsets （详见WPTag 的属性）

cell 的contentView  为  WPTagView 可以更改 每个cell中 tag 的布局 单选多选 （详见WPTagView的属性）


使用方法
self.tagMenu = [[WPTagMenuView alloc]init];
self.tagMenu.dataSource = self;

在代理方法中回答 数据相关问题  （类似tableView）
 
// 显示 WPTagMenuView
[self.tagMenu showTagMenuAtSuperView:sender];

// 隐藏 WPTagMenuView
[self.tagMenu dismissTagMenu];

// 此方法 会 重置 选中 的WPTagMenuView
[self.tagMenu resetTagMenu];
