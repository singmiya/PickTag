//
//  PickTagView.h
//  PickTag
//
//  Created by Somiya on 2019/2/24.
//  Copyright © 2019 Somiya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PickTagDelegate <NSObject>
- (void)confirmDidClick:(NSString *)tag;
- (void)addTagDidClick:(UIAlertController *)alertVC;
@end

@interface PickTagView : UIView
@property (nonatomic, assign) id<PickTagDelegate> ptDelegate;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

/**
 * 展示
 */
- (void)showPickTagViewInView:(UIView *)view;
/**
 * 关闭
 */
- (void)hidePickTagView;
@end
