//
//  ViewController.m
//  GrandLoginRegisterVC
//
//  Created by W_Lee on 16/8/28.
//  Copyright © 2016年 W_Lee. All rights reserved.
//  我的简书地址:http://www.jianshu.com/users/9be6d38c4bc5/latest_articles

//

#import "ViewController.h"
//
#import "WLModalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)modalLoginVC:(UIButton *)sender {
    //
    WLModalViewController * modalVC = [[WLModalViewController alloc] init];
    
    [self presentViewController:modalVC animated:YES completion:^{
        //nothing
    }];
}



@end
