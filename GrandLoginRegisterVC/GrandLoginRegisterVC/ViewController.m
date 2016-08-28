//
//  ViewController.m
//  GrandLoginRegisterVC
//
//  Created by hudongshili on 16/8/28.
//  Copyright © 2016年 hudongshili. All rights reserved.
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
