//
//  BankAccount.h
//  KVCTest
//
//  Created by Iris on 2019/4/9.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"
#import "Transaction.h"

typedef struct programmer {
    char *name;
    int age;
    int phone;
}Programmer;

@interface BankAccount : NSObject
@property (nonatomic, copy) NSNumber *currentBalance;
@property (nonatomic, strong) Person *owner; //一对一
@property (nonatomic, copy) NSArray<Transaction *>  *transactions;//一对多
@property (nonatomic, assign) Programmer programmer;

@end
