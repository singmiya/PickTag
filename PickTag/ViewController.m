//
//  ViewController.m
//  PickTag
//
//  Created by Somiya on 2019/2/24.
//  Copyright © 2019 Somiya. All rights reserved.
//
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#import "ViewController.h"
#import "PickTagView.h"

@interface ViewController ()
@property (nonatomic, strong) PickTagView *pickTagView;
@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = @[@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签",@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签",@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签",@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签",@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签",@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签",@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签",@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签",@"推荐",@"热点",@"汽车",@"财经频道",@"热点",@"社会",@"明星八卦",@"IT科技",@"移动互联网",@"金融",@"大数据",@"股票期货",@"食品安全新闻",@"自定义标签"];
    [self initPickTagView];
}
- (void)initPickTagView {
    self.pickTagView = [[PickTagView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150) dataSource:self.dataSource delegate:self];

    [self.pickTagView setConfirmAction:^(NSString *title) {
        NSLog(@"confirm butn clicked!!! %@", title);
    }];
}
- (IBAction)show:(id)sender {
    [self.pickTagView showPickTagViewInView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
