//
//  WLTextField.m
//  百思项目
//
//  Created by 陈芳芳 on 16/5/29.
//  Copyright © 2016年 wonwinlee. All rights reserved.
//

#import "WLTextField.h"

@interface WLTextField ()
@property (strong,nonatomic)  UILabel * placeholderlabel;
@end

@implementation WLTextField
//
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置主题色
        self.tintColor = [UIColor whiteColor];
        // 监听开始编辑
        [self addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
        // 监听结束编辑
        [self addTarget:self action:@selector(endBegin) forControlEvents:UIControlEventEditingDidEnd];
        // 拿到self.placeholder的真实属性
        UILabel * label = [self valueForKey:@"placeholderLabel"];
        // 设置占位文字颜色
        label.textColor = [UIColor lightTextColor];
        // 保存
        self.placeholderlabel = label;
    }
    return self;
}
//
- (void)awakeFromNib
{
    // 设置主题色
    self.tintColor = [UIColor whiteColor];
    // 监听开始编辑
    [self addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
    // 监听结束编辑
    [self addTarget:self action:@selector(endBegin) forControlEvents:UIControlEventEditingDidEnd];
    // 拿到self.placeholder的真实属性
    UILabel * label = [self valueForKey:@"placeholderLabel"];
    // 设置占位文字颜色
    label.textColor = [UIColor lightTextColor];
    // 保存
    self.placeholderlabel = label;
}
//
- (void)editBegin
{
    // 设置占位文字颜色
    self.placeholderlabel.textColor = [UIColor whiteColor];
}
//
- (void)endBegin
{
    // 设置占位文字颜色
    self.placeholderlabel.textColor = [UIColor lightTextColor];
}



@end
