//
//  ViewController.m
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-17.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "TestViewController.h"
#import "SSCellViewItem.h"
#import "SSCellViewSection.h"

@interface TestViewController () <SSOProviderDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //  self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.provider = [[SSOBaseTableViewProvider alloc] init];

    self.tableView.delegate = self.provider;
    self.tableView.dataSource = self.provider;
    self.provider.inputData = [self populateTable].mutableCopy;
    self.provider.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)populateTable {

    NSMutableArray *array = [[NSMutableArray alloc] init];
    SSCellViewSection *section = [[SSCellViewSection alloc] init];
    SSCellViewItem *item = [[SSCellViewItem alloc] init];
    NSString *object1 = @"TestString";

    item.cellHeight = 20;
    item.objectData = object1;
    item.cellReusableIdentifier = @"TestCell";

    [section.rows addObject:item];

    [array addObject:section];

    return array;
}

@end
