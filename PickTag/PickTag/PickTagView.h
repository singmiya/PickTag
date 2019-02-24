//
//  PickTagView.h
//  PickTag
//
//  Created by Somiya on 2019/2/24.
//  Copyright © 2019 Somiya. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ConfirmAction)(NSString *);

@interface PickTagView : UIView
@property (nonatomic, assign) ConfirmAction confirmAction;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource delegate:(id)delegate;

/**
 * 展示
 */
- (void)showPickTagViewInView:(UIView *)view;
/**
 * 关闭
 */
- (void)hidePickTagView;
@end
