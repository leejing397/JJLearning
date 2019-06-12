//
//  GXLoginViewModel.h
//  GXRACDemo
//
//  Created by Iris on 2019/6/12.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GXLoginModel;
@class RACCommand;

@interface GXLoginViewModel : NSObject
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *pwd;

@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) GXLoginModel *loginModel;

@property (nonatomic,strong) RACCommand *loginBtnEnableCmd;
@property (nonatomic,strong) RACCommand *loginActionCmd;

@end
