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
#import "GXKFCModel.h"
#import "GXBlueView.h"
#import <NSObject+RACKVOWrapper.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textAccount;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@property (strong,nonatomic) GXLoginViewModel *viewModel;

@property (nonatomic, strong) id<RACSubscriber> subscriber;
@property (nonatomic, weak) GXBlueView *blueView;

@property (nonatomic, strong) RACDisposable *timeDisposable;
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

    [self RACCommandTest];
}

- (void)test2 {
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
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
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
        [subscriber sendNext:@"发送信号就在创建信号里面"];
        return nil;
        
    }];
    //2.订阅信号(热信号!!)
    [signal subscribeNext:^(id x) {
//        x:信号发送的内容!!
        NSLog(@"%@",x);
    }];
}

- (void)test3 {
    RACDisposable *disposable = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"来啦");
        //若强引用subscriber
        _subscriber = subscriber;
        
        [subscriber sendNext:@"hello"];
        RACDisposable *disposable = [RACDisposable disposableWithBlock:^{
            //清空资源
            NSLog(@"哈哈");
        }];
        return disposable;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"发送的内容%@",x);
    }];
    
    [disposable dispose];
}

- (void)test4 {
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    //2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"发送的内容为%@",x);
    }];
    
    //3.发送信号
    [subject sendNext:@"hello world"];
}

#pragma mark RAC集合类
- (void)collection1 {
    RACTuple *tuple = [RACTuple tupleWithObjects:@"123",@"234",@"345", nil];
    NSString *str = tuple.first;
    NSLog(@"%@",str);
}

- (void)collection2 {
    NSArray *array = @[@"123",@"234",@"345"];
//    RACSequence *requence = [array rac_sequence];
//    RACSignal *signal = [requence signal];
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    //改为链式编程
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)collection3 {
    NSDictionary *dict = @{@"a":@"12",@"b":@"34"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        //x的class是RACTwoTuple
        NSLog(@"%@",x);
    }];
    
    [dict.rac_keySequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"key=%@",x);
    }];

    [dict.rac_valueSequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"value=%@",x);
    }];
    
    //字典转集合
    //在这里 字典 返回的是一个RACTuple（元祖），
    //通过下标去取出我们对应的 key、value,这样感觉是不是很不爽啊，这里我们介绍RAC的一个宏 RACTupleUnpack: 它就是用来解析元祖
    [dict.rac_sequence.signal subscribeNext:^(RACTuple* x) {
        NSString * key = x[0];
        NSString * value = x[1];
        NSLog(@"%@%@",key,value);
        //RACTupleUnpack:用来解析元祖
        //宏里面的参数,传需要解析出来的变量名称
        // = 右边,放需要解析的元祖
        RACTupleUnpack(NSString *key1,NSString *value1) = x;
        NSLog(@"%@ : %@",key1,value1);
    }];
}

- (void)collection4 {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"kfc.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    //map会将一个集合中的所有元素都映射成一个新的对象!
    NSArray *modelsArray = [[array.rac_sequence map:^id _Nullable(id  _Nullable value) {
        //返回模型!!
        return  [GXKFCModel kfcWithDict:value];
    }] array];
    NSLog(@"modelsArray=%@",modelsArray);
}

#pragma mark 常见用法
//代替代理
- (void)commonUsage {
    GXBlueView *blueView =[[GXBlueView alloc]initWithFrame:CGRectMake(100, 60, 100, 50)];
    [self.view addSubview:blueView];
    blueView.backgroundColor = [UIColor blueColor];
    [[blueView rac_signalForSelector:@selector(didClickBtn:)]subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"点击了按钮");
    }];
}

//代理KVO
- (void)commonUsage1 {
    GXBlueView *blueView = [[GXBlueView alloc]initWithFrame:CGRectMake(100, 60, 100, 50)];
    [self.view addSubview:blueView];
    self.blueView = blueView;
//    rac_observeKeyPath:options:observer:block
//    [blueView rac_observeKeyPath:@"frame"
//                         options:NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew observer:nil
//                           block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//                               NSLog(@"value= %@",value);
//                               NSLog(@"%@",change);
//    }];
    
    [[blueView rac_valuesForKeyPath:@"frame" observer:nil]subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int x = 50;
    x++;
    self.blueView.frame = CGRectMake(x, 50, 200, 200);
}

//代替通知
- (void)commonUsage2 {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

//监听文本框
- (void)commonUsage3 {
    [[self.textAccount rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"改变了%@",x);
    }];
}

//代替NSTimer
- (void)commonUsage4 {
    
    self.timeDisposable = [[RACSignal interval:1.0f onScheduler:[RACScheduler scheduler]]subscribeNext:^(NSDate * _Nullable x) {
         NSLog(@"%@",[NSThread currentThread]);
    }];
    
}

- (void)dealloc {
    [self.timeDisposable dispose];
}

#pragma mark RAC高级用法
- (void)advancedUsage {
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据1");
        [subscriber sendNext:@"你好呀"];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据2");
        [subscriber sendNext:@"我不好呀"];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(updateUIWithOneData:TwoData:) withSignalsFromArray:@[signal1,signal2]];
}


- (void)updateUIWithOneData:(id )oneData TwoData:(id )twoData {
    NSLog(@"%@",[NSThread currentThread]);
    //拿到数据更新UI
    NSLog(@"UI!!%@%@",oneData,twoData);
}

#pragma mark RACMulticastConnection
- (void)RACMulticastConnectionTest{
    //不管订阅多少次信号,就只会请求一次数据
    //RACMulticastConnection:必须要有信号
    //1.创建信号
    RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //发送网络请求
        NSLog(@"发送请求");
        //发送数据
        [subscriber sendNext:@"请求到的数据"];
        
        return nil;
    }];
    
    //2.将信号转成连接类!!
    RACMulticastConnection *connection = [signal publish];
    
    //3.订阅连接类的信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"A处在处理数据%@",x);
    }];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"B处在处理数据%@",x);
    }];
    
    //4.连接
    [connection connect];
}

- (void)RACCommandTest {
    //1.创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input==%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"哈哈"];
            return nil;
        }];
    }];
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"12");
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"是什么鬼：%@",x);
        }];
        NSLog(@"接收数据===%@",x);
    }];
    //2，执行命令
    RACSignal *signal = [command execute:@"你猜猜："];
    //3.订阅信号
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"接收数据：%@",x);
//    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
