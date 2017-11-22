//
//  CBaseViewController.h
//  crd
//
//  Created by 笔记本 on 2017/3/31.
//  Copyright © 2017年 crd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomerRightButtonDelegate <NSObject>

@optional

- (void)rightButtonAction;

@end

@interface CBaseViewController : UIViewController

- (void)showNavigationBar;
- (void)hideNavigationBar;

- (void)showTabBar;
- (void)hideTabBar;

- (void)createLeftButton;

- (UIView *)createLeftView;
/**
 *  自定义navigationBar右边按钮
 *
 *  @param image 按钮图片
 */
- (void)createRightButtonWithImage:(UIImage *)image;
- (void)createRightButtonWithImage:(UIImage *)image
                             width:(CGFloat)width
                            height:(CGFloat)height;

/**
 *  自定义navigationBar右边按钮
 *
 *  @param string 按钮文字
 */
- (void)createRightButtonWithString:(NSString *)string;
- (void)createRightButtonWithString:(NSString *)string
                              color:(UIColor *)color;

- (void)removeRightButton;

- (void)leftAction;

- (void)rightAction;

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property (nonatomic, assign) BOOL isNetworkReachable;

@end
