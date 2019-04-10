//
//  Person.m
//  KVCTest
//
//  Created by Iris on 2019/4/9.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "Person.h"

@implementation Person
// 重写UndefinedKey:方法
// getter
- (id)valueForUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"sex"]) {
        return @"人妖";
    }
    return nil;
}
// setter
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
