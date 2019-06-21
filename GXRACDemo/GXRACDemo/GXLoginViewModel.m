//
//  GXLoginViewModel.m
//  GXRACDemo
//
//  Created by Iris on 2019/6/12.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "GXLoginViewModel.h"

#import <ReactiveObjC.h>
#import "GXLoginModel.h"

@implementation GXLoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initCommand];
        [self initSubscribe];
    }
    return self;
}

- (void)initSubscribe {
    [RACObserve(self, account) subscribeNext:^(id  _Nullable x) {
        [self checkSubmitEnable];

    }];
    
    [RACObserve(self, pwd) subscribeNext:^(id  _Nullable x) {
        [self checkSubmitEnable];
    }];
}

- (void)checkSubmitEnable {
    //- (RACSignal *)execute:(id)input  执行命令
    [self.loginBtnEnableCmd execute:nil];
}

- (void)initCommand {
    self.loginBtnEnableCmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self racForSubmitEnable];
    }];
    self.loginActionCmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self racForlogin];
    }];
}

- (RACSignal *)racForSubmitEnable {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        BOOL status = self.account.length == 3 && self.pwd.length == 4;
        [subscriber sendNext:@(status)];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)racForlogin {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            GXLoginModel *result = [[GXLoginModel alloc]init];
            if ([self.account isEqualToString:@"123"] && [self.pwd isEqualToString:@"1234"]) {
                result.userId = [NSString stringWithFormat:@"%@%@",self.account,self.pwd];
                result.displayName = result.userId;
                self.error = nil;
            }else {
                self.error = [NSError errorWithDomain:@"-1" code:405 userInfo:@{@"des":@"账号密码错误"}];
            }
            self.loginModel = result;
            
            [subscriber sendNext:self];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}
@end
