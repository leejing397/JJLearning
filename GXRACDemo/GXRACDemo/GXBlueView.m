//
//  GXBlueView.m
//  GXRACDemo
//
//  Created by Iris on 2019/6/21.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "GXBlueView.h"

@implementation GXBlueView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        [button setBackgroundColor:[UIColor redColor]];
        [self addSubview:button];
        [button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)didClickBtn:(UIButton *)button {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
