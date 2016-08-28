//
//  WLModalViewController.m
//  百思项目
//
//  Created by 陈芳芳 on 16/5/28.
//  Copyright © 2016年 wonwinlee. All rights reserved.
//

#import "WLModalViewController.h"

#import "WLModalView.h"

@interface WLModalViewController ()
// 中间的view
@property (weak, nonatomic) IBOutlet UIView *middleView;
// 自定义的Scrollview
@property (strong,nonatomic) WLModalView *scrView;
//间隔
@property (assign,nonatomic) CGFloat margin;
@property (weak, nonatomic) IBOutlet UILabel *quikLoginLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerUserBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
 
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerBtnLayoutWidth;
/** 视图是否为首次显示 */
@property (assign, nonatomic) BOOL firstVisible;
@end

@implementation WLModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 把layer设为空
    self.registerUserBtn.layer.mask = [[CALayer alloc]init];
    
    self.quikLoginLabel.layer.mask = [[CALayer alloc]init];
    
    //shezhi
    self.view.layer.contents = (id)([UIImage imageNamed:@"login_register_background"].CGImage);
    
    WLModalView * scrView = [[[NSBundle mainBundle] loadNibNamed:@"WLModalScrollView" owner:nil options:nil] lastObject];
    //右边居中
    //    scrView.x = self.view.centerX-scrView.liftView.centerX-353;
    //    scrView.liftView.centerX = self.view.centerX;
    scrView.hyb_originX = [UIScreen mainScreen].bounds.size.width;
    [self.middleView  addSubview:scrView];
    
    self.scrView = scrView;
    
    [scrView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    /**===========================scroll计算逻辑============================= */
    
    
}
//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //给登录按钮加动画 从中间向两边动画
    [self setupAnimationWithStartRect:CGRectMake(self.quikLoginLabel.hyb_width/2, 0, 0, self.quikLoginLabel.hyb_height) endRect:CGRectMake(0, 0, self.quikLoginLabel.hyb_width, self.quikLoginLabel.hyb_height) object:self.quikLoginLabel duration:1];
    //注册按钮动画
    [self setupAnimationWithStartRect:CGRectMake(0, 0, 0, self.registerUserBtn.hyb_height) endRect:CGRectMake(0, 0, CGRectGetWidth(self.registerUserBtn.frame), CGRectGetHeight(self.registerUserBtn.frame)) object:self.registerUserBtn duration:1];

    //关闭按钮动画
    [UIView animateWithDuration:0.5 animations:^{
        
        // 旋转动画旋转180度
        self.closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
        
    }];
    
    // 先缩小 bottomView动画
    self.bottomView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //再恢复
        self.bottomView.transform = CGAffineTransformIdentity;
    } completion:nil];
  
}
//
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //
    if (!self.firstVisible) {
        //
        [UIView animateWithDuration:0.45 animations:^{
            //
            //左边距中
            self.scrView.hyb_originX = self.view.hyb_centerX-self.scrView.liftView.hyb_centerX;
        }];
        //
        self.firstVisible = YES;
    }
}
//
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//
-(void)loginBtnClick
{
    NSLog(@"denglu 成功");
}
//注册按钮
- (IBAction)registerBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
/**===========================scroll计算逻辑============================= */
    if (sender.selected) {
//        self.registerBtnLayoutWidth.constant = 100;

        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:kNilOptions animations:^{
            //右边居中
            self.scrView.hyb_originX = self.view.hyb_centerX-self.scrView.liftView.hyb_centerX-353;
            // 353是liftview和rightview的间距
        } completion:nil];
    }else{
//        self.registerBtnLayoutWidth.constant = 80;
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:kNilOptions animations:^{
            //左边距中
            self.scrView.hyb_originX = self.view.hyb_centerX-self.scrView.liftView.hyb_centerX;
        } completion:nil];
    }
    //退出键盘
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

    
}
//关闭按钮
- (IBAction)closeBtnClick:(UIButton *)sender {
    
    //退出键盘
    [self.view endEditing:YES];
    //退出控制器的view
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//设置CA路径动画 给控件Rect设置动画
-(void)setupAnimationWithStartRect:(CGRect)startRect endRect:(CGRect)endRect object:(UIView *)view duration:(NSTimeInterval)duration {
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:startRect];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:endRect];
    
    CAShapeLayer *quickMask = [[CAShapeLayer alloc]init];
    quickMask.path = endPath.CGPath;
    quickMask.fillColor = [UIColor whiteColor].CGColor;
    view.layer.mask = quickMask;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = duration;
    animation.beginTime = CACurrentMediaTime();
    animation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    [quickMask addAnimation:animation forKey:@"path"];
    
}
//设置CA缩放动画 给控件Scale设置动画
-(void)setAnimationWithStartScale:(CGFloat)startScale endScale:(CGFloat)endScale object:(UIView *)view duration:(NSTimeInterval)duration {
    
//    CGAffineTransform startScale = CGAffineTransformMakeScale(0.01, 0.01);
    

    
//    CAShapeLayer *quickMask = [[CAShapeLayer alloc]init];
////    quickMask.path = endPath.CGPath;
//    quickMask.fillColor = [UIColor whiteColor].CGColor;
//    view.layer.mask = quickMask;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = duration;
    animation.beginTime = CACurrentMediaTime();
    animation.fromValue =@(startScale);
    animation.toValue = @(endScale);
    [view.layer addAnimation:animation forKey:@"transform.scale"];
    
}


@end
