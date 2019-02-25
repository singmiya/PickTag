# PickTag
标签选择器

## 使用方式
1. 初始化
```
- (void)initPickTagView {
    	self.pickTagView = [[PickTagView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150) dataSource:self.dataSource delegate:self];

    	[self.pickTagView setConfirmAction:^(NSString *title) {
        	NSLog(@"confirm butn clicked!!! %@", title);
    	}];
}
```

2. 显示
	```
	[self.pickTagView showPickTagViewInView:self.view];
	```

