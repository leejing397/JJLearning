//
//  JJPhotoInCellModel.m
//  HXPhotoTest
//
//  Created by Iris on 2019/4/11.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "JJPhotoInCellModel.h"

@implementation JJPhotoInCellModel

- (CGFloat)cellHeight {
    _cellHeight = self.photoViewHeight;
    return _cellHeight;
}
- (CGFloat)photoViewHeight {
    if (_photoViewHeight == 0) {
        _photoViewHeight = (([UIScreen mainScreen].bounds.size.width - 24) - 3 * (3 - 1)) / 3;
    }
    return _photoViewHeight;
}

- (NSMutableArray *)endCameraList {
    if (!_endCameraList) {
        _endCameraList = [NSMutableArray array];
    }
    return _endCameraList;
}
- (NSMutableArray *)endCameraPhotos {
    if (!_endCameraPhotos) {
        _endCameraPhotos = [NSMutableArray array];
    }
    return _endCameraPhotos;
}
- (NSMutableArray *)endCameraVideos {
    if (!_endCameraVideos) {
        _endCameraVideos = [NSMutableArray array];
    }
    return _endCameraVideos;
}
- (NSMutableArray *)endSelectedCameraList {
    if (!_endSelectedCameraList) {
        _endSelectedCameraList = [NSMutableArray array];
    }
    return _endSelectedCameraList;
}
- (NSMutableArray *)endSelectedCameraPhotos {
    if (!_endSelectedCameraPhotos) {
        _endSelectedCameraPhotos = [NSMutableArray array];
    }
    return _endSelectedCameraPhotos;
}
- (NSMutableArray *)endSelectedCameraVideos {
    if (!_endSelectedCameraVideos) {
        _endSelectedCameraVideos = [NSMutableArray array];
    }
    return _endSelectedCameraVideos;
}
- (NSMutableArray *)endSelectedList {
    if (!_endSelectedList) {
        _endSelectedList = [NSMutableArray array];
    }
    return _endSelectedList;
}
- (NSMutableArray *)endSelectedPhotos {
    if (!_endSelectedPhotos) {
        _endSelectedPhotos = [NSMutableArray array];
    }
    return _endSelectedPhotos;
}
- (NSMutableArray *)endSelectedVideos {
    if (!_endSelectedVideos) {
        _endSelectedVideos = [NSMutableArray array];
    }
    return _endSelectedVideos;
}
- (NSMutableArray *)iCloudUploadArray {
    if (!_iCloudUploadArray) {
        _iCloudUploadArray = [NSMutableArray array];
    }
    return _iCloudUploadArray;
}
@end
