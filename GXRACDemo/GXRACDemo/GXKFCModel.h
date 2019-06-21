//
//  GXKFCModel.h
//  GXRACDemo
//
//  Created by Iris on 2019/6/21.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXKFCModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

+ (instancetype)kfcWithDict:(NSDictionary *)dict;

@end
