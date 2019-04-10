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

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue
               forKey:(NSString *)inKey
                error:(out NSError * _Nullable __autoreleasing *)outError {
    if ([inKey isEqualToString:@"name"]) {
        if ([*ioValue isKindOfClass:[NSString class]]) {
            NSLog(@"yes == %d,ioValueClass == %@", YES, NSStringFromClass([*ioValue class]));
            return YES;
        }else{
            NSLog(@"no == %d,ioValueClass == %@", NO, NSStringFromClass([*ioValue class]));
            return NO;
        }
    }
    return YES;
}

- (BOOL)validateName:(id *)ioValue
               error:(NSError * __autoreleasing *)outError {
    if ((*ioValue == nil) || ([(NSString *)*ioValue length] < 2)) {
        if (outError != NULL) {
            *outError = [NSError errorWithDomain:NSCocoaErrorDomain
                                            code:1
                                        userInfo:@{ NSLocalizedDescriptionKey
                                                    : @"Name too short" }];
        }
        return NO;
    }
    return YES;
}

@end
