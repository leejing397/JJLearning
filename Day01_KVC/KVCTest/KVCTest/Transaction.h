//
//  Transaction.h
//  KVCTest
//
//  Created by Iris on 2019/4/9.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

@property (nonatomic, copy) NSString *payee;
@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSDate *date;

@end
