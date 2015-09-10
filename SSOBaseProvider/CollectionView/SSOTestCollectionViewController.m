//
//  SSOTestCollectionViewController.m
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-09.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOTestCollectionViewController.h"
#import "SSOTestCollectionCell.h"
#import "SSOTestModel.h"
#import "SSOProviderItem.h"
#import "SSOProviderSection.h"
#import "SSOBaseCollectionViewProvider.h"

NSString *const kCellRI = @"RIColID";
NSString *const kCellNibName = @"SSOTestCollectionCell";

@interface SSOTestCollectionViewController () <SSOProviderDelegate>
@property(weak, nonatomic) UICollectionView *collectionView;
@property(strong, nonatomic) SSOBaseCollectionViewProvider *provider;
@end

@implementation SSOTestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:collection];
    self.collectionView = collection;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    NSArray *data = [self createData];
    self.provider = [SSOBaseCollectionViewProvider newProviderForTableView:self.collectionView withData:data andDelegate:self];

    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //    SSOTestModel *a = [SSOTestModel new];
    //    a.namingString = @"t1";
    //    SSOTestModel *b = [SSOTestModel new];
    //    b.namingString = @"t2";
    //    SSOTestModel *c = [SSOTestModel new];
    //    c.namingString = @"t3";
    //
    //    SSOProviderItem *i1 = [SSOProviderItem newProviderItemWithData:a reusableIdentifier:kCellRI cellNibName:kCellNibName onBundleOrNil:nil];
    //    SSOProviderItem *i2 = [SSOProviderItem newProviderItemWithData:b reusableIdentifier:kCellRI cellNibName:kCellNibName onBundleOrNil:nil];
    //    SSOProviderItem *i3 = [SSOProviderItem newProviderItemWithData:c reusableIdentifier:kCellRI cellNibName:kCellNibName onBundleOrNil:nil];
    //
    //    [self.provider addObjectsToProviderData:@[ i1, i2, i3 ] inSection:0];
    //
    //    [self.provider removeObjectsFromProvider:@[ i1, i3 ] inSection:0];
    //
    //    [self.provider updateProviderData:@[i3] inSection:0];
}

- (NSArray *)createData {
    SSOTestModel *a = [SSOTestModel new];
    a.namingString = @"Peste";
    SSOTestModel *b = [SSOTestModel new];
    b.namingString = @"Pesti";
    SSOTestModel *c = [SSOTestModel new];
    c.namingString = @"Pesh";

    SSOProviderItem *i1 = [SSOProviderItem newProviderItemWithData:a reusableIdentifier:kCellRI cellNibName:kCellNibName onBundleOrNil:nil];
    SSOProviderItem *i2 = [SSOProviderItem newProviderItemWithData:b reusableIdentifier:kCellRI cellNibName:kCellNibName onBundleOrNil:nil];
    SSOProviderItem *i3 = [SSOProviderItem newProviderItemWithData:c reusableIdentifier:kCellRI cellNibName:kCellNibName onBundleOrNil:nil];

    SSOProviderSection *section = [SSOProviderSection newSectionWithData:@[ i1, i2, i3 ]];
    return @[ section ];
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
