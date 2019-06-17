//
//  ViewController.m
//  NSInvocationDemo
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
    // Do any additional setup after loading the view, typically from a nib.
    [self test4];
}

#pragma mark 不带参数的例子
- (void)test1 {
    SEL myMethod = @selector(run);
    NSMethodSignature *sigature = [[self class] instanceMethodSignatureForSelector:@selector(run)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sigature];
    [invocation setSelector:myMethod];
    invocation.target = self;
    [invocation invoke];
}

- (void)run {
    NSLog(@"run go");
}

#pragma mark 带参数的方法
- (void)test2 {
    //设定方法的样子
    SEL myMethod = @selector(run:name2:);
    SEL myMethod1 = @selector(run);
    // 返回一个方法 如果那个方法找不到则返回nil
    NSMethodSignature *signature = [[self class]instanceMethodSignatureForSelector:myMethod1];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    // 设置target
    [invocation setSelector:myMethod];
    invocation.target = self;
    // 设置selectro
    NSString *name1 = @"小明";
    NSString *name2 = @"小红";
    [invocation setArgument:&name1 atIndex:2];
    [invocation setArgument:&name2 atIndex:3];
    [invocation invoke];
}

- (void)run:(NSString *)name1 name2:(NSString *)name2 {
    NSLog(@"%@和%@",name1,name2);
}


#pragma mark 带参数的方法
- (void)test3 {
    SEL myMethod = @selector(run:name2:);
    NSMethodSignature *signature = [[self class]instanceMethodSignatureForSelector:myMethod];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    id mySelf = self;
    NSString *name1 = @"小明";
    NSString *name2 = @"小红";
    [invocation setArgument:&mySelf atIndex:0];
    [invocation setArgument:&myMethod atIndex:1];
    [invocation setArgument:&name1 atIndex:2];
    [invocation setArgument:&name2 atIndex:3];
    NSLog(@"invocation.argumentsRetained===%d", invocation.argumentsRetained);
    NSLog(@"invocation.target==%@",invocation.target);
    NSLog(@"invocation.selector==%@",NSStringFromSelector(invocation.selector));
    [invocation invokeWithTarget:self];
    NSLog(@"invocation.target====%@",invocation.target);
    // 保留参数 和返回值
    [invocation retainArguments];
    NSLog(@"invocation.argumentsRetained===%d",invocation.argumentsRetained);
    [invocation invoke];
}

#pragma mark 带参数带返回值
- (void)test4 {
    // 返回值
    SEL myMethod2 = @selector(add:name2:name3:);
    SEL myMethod = @selector(run:name2:name3:);
    // 你要调用什么样的方法你就要给什么样的 样式，可以多不可以少
    // 你设置有返回值的，那么你必须要让有返回值的方法的样式
    NSMethodSignature * sig  = [[self class] instanceMethodSignatureForSelector:myMethod2];
    NSInvocation *invocatin = [NSInvocation invocationWithMethodSignature:sig];
    [invocatin setTarget:self];
    [invocatin setSelector:myMethod2];
    
    ViewController * view = self;
    NSString *name1 = @"小明";
    NSString *name2 = @"小张";
    NSString *name3 = @"小宝宝";
    [invocatin setArgument:&view atIndex:0];
    [invocatin setArgument:&myMethod2 atIndex:1];
    [invocatin setArgument:&name1 atIndex:2];
    [invocatin setArgument:&name2 atIndex:3];
    [invocatin setArgument:&name3 atIndex:4];
    [invocatin retainArguments];
    NSString * c = @"3";
    //我们将c的值设置为返回值
    [invocatin setReturnValue: &c];
    NSLog(@"c = %@",c);
    NSString * d = @"2";
    //取这个返回值
    [invocatin getReturnValue:&d];
    NSLog(@"d = %@",d);
    [invocatin invoke];
    NSLog(@"c = %@",c);
    
    NSLog(@"d = %@",d);
    
}

- (NSString *)add:(NSString *)name name2:(NSString *)name2 name3:(NSString *)name3 {
    NSLog(@"add + %@ + %@ + %@",name,name2,name3);
    return @"hihi";
}

- (void)run:(NSString *)name name2:(NSString *)name2 name3:(NSString *)name3 {
    NSLog(@"run + %@ + %@ + %@",name,name2,name3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
