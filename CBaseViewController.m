//
//  CBaseViewController.m
//  crd
//
//  Created by 笔记本 on 2017/3/31.
//  Copyright © 2017年 crd. All rights reserved.
//

#import "CBaseViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface CBaseViewController ()

@end

@implementation CBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self showNavigationBar];
    
    [self hideTabBar];
    
//    [self addStatusBar];

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self hideNavigationBar];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

- (void)dealloc {
    NSLog(@"release %@", self.title);
}

#pragma mark - UI
- (void)initNavigationBar {
    
}

- (void)createTitleLabel {
    
}

- (void)createLeftButton {
    
    UIView *leftView = [self createLeftView];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    [leftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftAction)]];
}

- (UIView *)createLeftView {
    
    CGFloat fMarginLeft   = 18;
    CGFloat fImageWidth   = 10;
    CGFloat fImageHeight  = 19;
    
    UIView *leftView = [[UIView alloc]
                        initWithFrame:CGRectMake(0, 0, fMarginLeft + fImageWidth * 3 , TitleBarHeight)];
    UIImageView *img = [[UIImageView alloc]
                        initWithFrame:CGRectMake(0, (CGRectGetHeight(leftView.frame) - fImageHeight)/2, fImageWidth, fImageHeight)];
    [img setImage:ImageNamed(@"navigation_bar_back_img")];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [leftView addSubview:img];
    
    return leftView;
}

- (void)addStatusBar {
    
    BOOL hasStatusBarView = FALSE;
    NSArray *list=[self.view subviews];
    for (id obj in list) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView *view=(UIView *)obj;
            if (view.tag == 1010) {
                hasStatusBarView = YES;
                break;
            }
        }
    }
    if (hasStatusBarView) {
        return;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, StatusBarHeight)];
    view.backgroundColor = RGB_WHITE;
    view.tag = 1010;
    
    [self.view addSubview:view];
}

- (void)createRightButtonWithImage:(UIImage *)image {
    
    CGFloat fImageWidth   = 20;
    CGFloat fImageHeight  = 20;
    [self createRightButtonWithImage:image width:fImageWidth height:fImageHeight];
}

- (void)createRightButtonWithImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height {
    
    UIView *rightView = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, 66, TitleBarHeight)];
    
    UIImageView *img = [[UIImageView alloc]
                        initWithFrame:CGRectMake(CGRectGetWidth(rightView.frame) - width, (CGRectGetHeight(rightView.frame) - height)/2, width, height)];
    if (image) {
        [img setImage:image];
    } else {
        [img setImage:ImageNamed(@"navigation_bar_phone_item.png")];
    }
    
    img.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:img];
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [rightView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction)]];
}

- (void)createRightButtonWithString:(NSString *)string {
    
    [self createRightButtonWithString:string color:nil];
}

- (void)createRightButtonWithString:(NSString *)string
                              color:(UIColor *)color{
    
    if (!string || [string isEqualToString:@""]) {
        string = @"";
    }
    
    CGFloat fFontSize     = 16;
    CGFloat fLabelWidth   = fFontSize * (string.length + 1);
    CGFloat fLabelHeight  = 22;
    
    UIView *rightView = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 0, fLabelWidth, TitleBarHeight)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(rightView.frame) - fLabelHeight)/2, fLabelWidth, fLabelHeight)];
    label.text = string;
    if (color) {
        label.textColor = color;
    } else {
        label.textColor = RGB_WHITE;
    }
    label.font = FONT(fFontSize);
    label.textAlignment = NSTextAlignmentRight;
    [rightView addSubview:label];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [rightView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction)]];
}

- (void)removeRightButton {
    
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)leftAction {
    
    if ([self.navigationController.viewControllers count] != 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                ;
            }];
        }
    }
}

- (void)rightAction {
    
}

- (void)hideNavigationBar {
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)showNavigationBar {
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)hideTabBar {
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)showTabBar {
    
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Hide keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

#pragma mark 
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    
    return NO;
}

- (BOOL)isNetworkReachable {
    
    return [AFNetworkReachabilityManager sharedManager].reachable;
}
@end
