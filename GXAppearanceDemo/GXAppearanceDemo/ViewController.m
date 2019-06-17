//
//  ViewController.m
//  GXAppearanceDemo
//
//  Created by Iris on 2019/6/17.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开始吧";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"hello" style:0 target:self action:@selector(left)];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)left {
    NSLog(@"哈哈哈");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
