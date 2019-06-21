//
//  GXKFCModel.m
//  GXRACDemo
//
//  Created by Iris on 2019/6/21.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "GXKFCModel.h"

@implementation GXKFCModel

+ (instancetype)kfcWithDict:(NSDictionary *)dict {
    GXKFCModel *kfc = [[GXKFCModel alloc]init];
    
    [kfc setValuesForKeysWithDictionary:dict];
    
    return kfc;
}
@end
