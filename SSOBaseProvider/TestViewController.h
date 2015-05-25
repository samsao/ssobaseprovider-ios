//
//  ViewController.h
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-17.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSOBaseTableViewProvider.h"

@interface TestViewController : UIViewController

@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(nonatomic, strong) SSOBaseTableViewProvider *provider;

@end
