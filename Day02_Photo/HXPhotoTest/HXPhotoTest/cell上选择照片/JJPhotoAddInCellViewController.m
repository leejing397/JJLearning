//
//  JJPhotoAddInCellViewController.m
//  HXPhotoTest
//
//  Created by Iris on 2019/4/11.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "JJPhotoAddInCellViewController.h"

#import "Cell/JJPhotoInCellTableViewCell.h"
#import "Model/JJPhotoInCellModel.h"
#import <HXPhotoView.h>

static NSString *const kPhotoInCellID = @"kPhotoInCellID";
static NSString *const kCellID = @"kCellID";

@interface JJPhotoAddInCellViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *cellPhotoTableView;
@property (nonatomic,strong) NSIndexPath *photoIndexPath;
@end

@implementation JJPhotoAddInCellViewController
- (UITableView *)cellPhotoTableView {
    if (_cellPhotoTableView == nil) {
        _cellPhotoTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _cellPhotoTableView.delegate = self;
        _cellPhotoTableView.dataSource = self;
        [_cellPhotoTableView registerClass:[JJPhotoInCellTableViewCell class] forCellReuseIdentifier:kPhotoInCellID];
        [_cellPhotoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    }
    return _cellPhotoTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.cellPhotoTableView];
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        JJPhotoInCellModel *model = [[JJPhotoInCellModel alloc]init];
        [self.dataArray addObject:model];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        JJPhotoInCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPhotoInCellID];
        JJPhotoInCellModel *model = self.dataArray[indexPath.section];
        model.section = indexPath.section;
        cell.model = model;
        
        self.photoIndexPath = indexPath;
        HXWeakSelf
        [cell setPhotoViewChangeHeightBlock:^(JJPhotoInCellTableViewCell *mycell) {
            NSIndexPath *myIndexPath = [weakSelf.cellPhotoTableView indexPathForCell:mycell];
            if (myIndexPath) {
                [weakSelf.cellPhotoTableView reloadRowsAtIndexPaths:@[myIndexPath] withRowAnimation:0];
            }
        }];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.textLabel.text = @"hello";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == self.photoIndexPath ) {
        JJPhotoInCellModel *model = self.dataArray[indexPath.section];
        CGFloat cellHeight = model.cellHeight;
        NSLog(@"section=%ld,row=%ld,cellheight=%f",(long)indexPath.section,indexPath.row,cellHeight);
        return cellHeight;
    }
    return 44.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
