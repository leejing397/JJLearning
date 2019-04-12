//
//  JJPhotoInCellTableViewCell.h
//  HXPhotoTest
//
//  Created by Iris on 2019/4/11.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JJPhotoInCellModel.h"

@class HXPhotoView;

@interface JJPhotoInCellTableViewCell : UITableViewCell

@property (strong, nonatomic) JJPhotoInCellModel *model;
/**  照片视图  */
@property (nonatomic, strong) HXPhotoView *photoView;
@property (copy, nonatomic) void (^photoViewChangeHeightBlock)(JJPhotoInCellTableViewCell *myCell);

@end
