//
//  SSOBaseProviderTests.m
//  SSOBaseProviderTests
//
//  Created by Gabriel Cartier on 2015-04-17.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SSOBaseTableViewProvider.h"
#import "TestViewController.h"

@interface SSOBaseProviderTests : XCTestCase
@property(nonatomic, strong) TestViewController *testVc;

@end

@implementation SSOBaseProviderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testVc = [[TestViewController alloc] init];
    [self.testVc viewDidLoad];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBaseProviderExists {
    XCTAssertNotNil(self.testVc.provider, @"baseTableViewProvider is nil");
}

- (void)testProviderHasInputDataCount {
    //    XCTAssertNotEqual(self.testVc.provider.inputData.count, 0, @"provider inputData is empty");
}

- (void)testProviderIsDelegate {

    XCTAssertNotNil(self.testVc.provider.delegate, @" provider has no delegate");
}

- (void)testTableViewHasDelegate {

    XCTAssertNotNil(self.testVc.tableView.delegate, @" tableView has no delegate");
}

- (void)testTableViewHasDataSource {

    XCTAssertNotNil(self.testVc.tableView.dataSource, @" tableView has no dataSource");
}

@end