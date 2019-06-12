//
//  ViewController.m
//  GXRACDemo
//
//  Created by Iris on 2019/6/12.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import "GXLoginViewModel.h"
#import "GXLoginModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textAccount;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@property (strong,nonatomic) GXLoginViewModel *viewModel;
@end

@implementation ViewController
- (GXLoginViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[GXLoginViewModel alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setupUI];
    [self initCommand];
    
    [self initSubscribe];
}

- (void)setupUI {
    self.btnSubmit.enabled = NO;
    [self.btnSubmit setBackgroundImage:[self createImageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
    [self.btnSubmit setBackgroundImage:[self createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
}


- (UIImage*)createImageWithColor:(UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark 关联赋值
- (void)initCommand {
    RAC(self.viewModel,account) = self.textAccount.rac_textSignal;
    RAC(self.viewModel,pwd) = self.txtPwd.rac_textSignal;
}

- (void)initSubscribe {
    [[self.viewModel.loginBtnEnableCmd.executionSignals switchToLatest]subscribeNext:^(id  _Nullable x) {
        self.btnSubmit.enabled = [x boolValue];
        self.lblResult.text = @"";
    }];
    
    [[self.viewModel.loginActionCmd.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在请求。。。");
        }else {
            NSLog(@"加载完毕");
        }
    }];
    
    [[self.viewModel.loginActionCmd.executionSignals switchToLatest]subscribeNext:^(id  _Nullable x) {
        GXLoginViewModel *loginViewModel = x;
        if (!loginViewModel) {
            return;
        }
        if (loginViewModel.error) {
            
            self.lblResult.text = [NSString stringWithFormat:@"%@",loginViewModel.error.userInfo[@"des"]];
            NSLog(@"登录失败");
        }else {
            
            self.lblResult.text = loginViewModel.loginModel.userId;
            NSLog(@"登录成功");
        }
    }];
}

- (IBAction)touchAction:(id)sender {
    NSLog(@"我在登录呀");
    [self.viewModel.loginActionCmd execute:nil];
}

- (void)test1 {
    //1.创建信号(冷信号!)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"Here I am!");
        //3.发送数据subscriber它来发送
        //        [subscriber sendNext:@"发送信号就在创建信号里面"];
        return nil;
        
    }];
    
    //2.订阅信号(热信号!!)
    [signal subscribeNext:^(id x) {
        //x:信号发送的内容!!
        NSLog(@"%@",x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
