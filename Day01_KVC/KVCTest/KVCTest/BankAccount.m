//
//  BankAccount.m
//  KVCTest
//
//  Created by Iris on 2019/4/9.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount

- (void)setNilValueForKey:(NSString *)key {
    if ([key isEqualToString:@"currentBalance"]) {
        [self setValue:@(0) forKey:@"currentBalance"];
    } else {
        [super setNilValueForKey:key];
    }
}

@end
