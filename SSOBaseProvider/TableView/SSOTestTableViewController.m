//
//  SSOTestTableViewController.m
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-09.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOTestTableViewController.h"
#import "SSOBaseTableViewProvider.h"
#import "SSOProviderSection.h"
#import "SSOProviderItem.h"
#import "SSOTestModel.h"

NSString *const kReuseIdentifier = @"RITest";
NSString *const kCellNib = @"SSOTestCell";

@interface SSOTestTableViewController () <SSOProviderDelegate>

@property(weak, nonatomic) UITableView *tableView;
@property(strong, nonatomic) SSOBaseTableViewProvider *provider;
@end

@implementation SSOTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    NSArray *data = [self createData];
    self.provider = [SSOBaseTableViewProvider newProviderForTableView:tableView withData:data andDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //        SSOTestModel *c = [SSOTestModel new];
    //        c.namingString = @"Test1";
    //
    //        SSOProviderItem *i1 = [SSOProviderItem newProviderItemWithData:c reusableIdentifier:kReuseIdentifier cellNibName:kCellNib onBundleOrNil:nil];
    //
    //        [self.provider addObject:i1 atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //
    //        SSOTestModel *a = [SSOTestModel new];
    //        a.namingString = @"test2";
    //        SSOTestModel *b = [SSOTestModel new];
    //        b.namingString = @"test3";
    //
    //        i1 = [SSOProviderItem newProviderItemWithData:a reusableIdentifier:kReuseIdentifier cellNibName:kCellNib onBundleOrNil:nil ];
    //        SSOProviderItem *i2 = [SSOProviderItem newProviderItemWithData:b reusableIdentifier:kReuseIdentifier cellNibName:kCellNib onBundleOrNil:nil];
    //
    //        [self.provider addObject:i1 atIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    //        [self.provider addObject:i2 atIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    //
    //        [self.provider removeObjectFromProvider:i1 inSection:0];
    //        [self.provider removeObjectsFromProvider:@[i1,i2] inSection:0];
    //        NSArray *data = [self createData];
    //        SSOProviderSection *sect = data.firstObject;
    //        [self.provider updateProviderData:sect.sectionItems inSection:0];
}

- (NSArray *)createData {
    SSOTestModel *a = [SSOTestModel new];
    a.namingString = @"Peste";
    SSOTestModel *b = [SSOTestModel new];
    b.namingString = @"Pesti";
    SSOTestModel *c = [SSOTestModel new];
    c.namingString = @"Pesh";

    SSOProviderItem *i1 = [SSOProviderItem newProviderItemWithData:a reusableIdentifier:kReuseIdentifier cellNibName:kCellNib onBundleOrNil:nil];
    SSOProviderItem *i2 = [SSOProviderItem newProviderItemWithData:b reusableIdentifier:kReuseIdentifier cellNibName:kCellNib onBundleOrNil:nil];
    SSOProviderItem *i3 = [SSOProviderItem newProviderItemWithData:c reusableIdentifier:kReuseIdentifier cellNibName:kCellNib onBundleOrNil:nil];

    SSOProviderSection *section = [SSOProviderSection newSectionWithData:@[ i1, i2, i3 ]];
    return @[ section ];
}

@end
