//
//  PickTagView.m
//  PickTag
//
//  Created by Somiya on 2019/2/24.
//  Copyright © 2019 Somiya. All rights reserved.
//

#define kControllerHeaderViewHeight                90
#define kControllerHeaderToCollectionViewMargin    0
#define kCollectionViewCellsHorizonMargin          12
#define kCollectionViewCellHeight                  30
#define kCollectionViewItemButtonImageToTextMargin 5

#define kCollectionViewToLeftMargin                16
#define kCollectionViewToTopMargin                 12
#define kCollectionViewToRightMargin               16
#define kCollectionViewToBottomtMargin             10

#define kCellImageToLabelMargin                    10
#define kCellBtnCenterToBorderMargin               19

#define KToolBarHeight                             44

#import "PickTagView.h"
#import "CollectionViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "CollectionHeaderView.h"
#import "ColorUtil.h"

typedef void(^ISLimitWidth)(BOOL yesORNo,id data);

static NSString * const kCellIdentifier           = @"CellIdentifier";
static NSString * const kHeaderViewCellIdentifier = @"HeaderViewCellIdentifier";

@interface PickTagView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) NSIndexPath *lastIP;
@property (nonatomic, strong) NSIndexPath *currentIP;
@property (nonatomic, assign) id delegate;
@end
@implementation PickTagView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource delegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.collectionView];
        [self addSubview:self.toolbar];
        self.dataSource = [dataSource mutableCopy];
        self.lastIP = nil;
        self.currentIP = nil;
        self.delegate = delegate;
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGRect collectionViewFrame = CGRectMake(0, KToolBarHeight, self.frame.size.width, self.frame.size.height - KToolBarHeight);
        UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.allowsMultipleSelection = YES;
        
        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
        _collectionView.scrollsToTop = NO;
    }
    
    //self.collectionView.scrollEnabled = NO;
    return _collectionView;
}

- (UIToolbar *)toolbar {
    if (_toolbar == nil) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, KToolBarHeight)];
        _toolbar.barStyle = UIBarStyleBlack;
        UIBarButtonItem *confirmButn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Confirm", nil) style:UIBarButtonItemStylePlain target:self action:@selector(confirmDidClick:)];
        [confirmButn setTintColor:UICOLOR_HEX(0xE54D42)];
        UIBarButtonItem *cancelButn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(cancelDidClick:)];
        [cancelButn setTintColor:UICOLOR_HEX(0xE54D42)];
        UIBarButtonItem *addButn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Add", nil) style:UIBarButtonItemStylePlain target:self action:@selector(addDidClick:)];
        [addButn setTintColor:UICOLOR_HEX(0xE54D42)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        _toolbar.items = @[cancelButn, space, addButn, space, confirmButn];

    }
    return _toolbar;
}

#pragma mark - actions
- (void)confirmDidClick:(id)sender {
    if (self.confirmAction != nil) {
        CollectionViewCell *cell = (CollectionViewCell *) [self.collectionView cellForItemAtIndexPath:self.currentIP];
        self.confirmAction(cell.titleLabel.text);
        [self hidePickTagView];
    }
}

- (void)cancelDidClick:(id)sender {
    [self hidePickTagView];
}

- (void)addDidClick:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"AddNewTag", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Confirm", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alertController.textFields.firstObject.text.length <= 0) {
            return;
        }
        [self.dataSource insertObject:alertController.textFields.firstObject.text atIndex:0];
        [self.collectionView reloadData];
        self.lastIP = nil;
        self.currentIP = nil;
    }]];
    [_delegate presentViewController:alertController animated:YES completion:nil];
}

- (void)showPickTagViewInView:(UIView *)view {
    CGRect frame = view.frame;
    __block CGRect selfFrame = self.frame;
    selfFrame.origin.y = frame.size.height;
    self.frame = selfFrame;
    [view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        selfFrame.origin.y = frame.size.height - selfFrame.size.height;
        self.frame = selfFrame;
    }];
}
- (void)hidePickTagView {
    CGRect frame = self.superview.frame;
    __block CGRect selfFrame = self.frame;
    [UIView animateWithDuration:0.5 animations:^{
        selfFrame.origin.y = frame.size.height;
        self.frame = selfFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    //cell.titleLabel.backgroundColor = [UIColor orangeColor];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    [cell resetStyle];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    self.lastIP = self.currentIP;
    if (self.lastIP != nil) {
        CollectionViewCell *lastCell = (CollectionViewCell *) [self.collectionView cellForItemAtIndexPath:self.lastIP];
        [lastCell unselect];
    }
    self.currentIP = indexPath;
    CollectionViewCell *currentCell = (CollectionViewCell *) [self.collectionView cellForItemAtIndexPath:self.currentIP];
    [currentCell select];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier forIndexPath:indexPath];
        NSString * str = indexPath.section == 0 ? @"我的订阅":@"未订阅";
        headerView.titleLabel.text = str;
        return (UICollectionReusableView *)headerView;
    }
    return nil;
}


- (float)getCollectionCellWidthText:(NSString *)text{
    float cellWidth;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:13]}];
    
    cellWidth = ceilf(size.width) + kCellBtnCenterToBorderMargin;
    cellWidth = [self checkCellLimitWidth:cellWidth isLimitWidth:nil];
    return cellWidth;
}


- (float)checkCellLimitWidth:(float)cellWidth isLimitWidth:(ISLimitWidth)isLimitWidth {
    float limitWidth = (CGRectGetWidth(self.collectionView.frame)-kCollectionViewToLeftMargin-kCollectionViewToRightMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth?isLimitWidth(YES,@(cellWidth)):nil;
        return cellWidth;
    }
    isLimitWidth?isLimitWidth(NO,@(cellWidth)):nil;
    return cellWidth;
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // cell 的宽
    NSString *text = self.dataSource[indexPath.row];
    float cellWidth = [self getCollectionCellWidthText:text];
    return CGSizeMake(cellWidth, kCollectionViewCellHeight);
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kCollectionViewCellsHorizonMargin;//cell之间的间隔
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //四周边距
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
}

@end
