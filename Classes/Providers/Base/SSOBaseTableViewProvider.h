//
//  SSOBaseTableViewProvider.h
//  SSOBaseProvider
//
//  Created by Nicolas Vincensini on 2015-01-07.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSOBaseProvider.h"

@protocol SSOBaseTableViewProviderDelegate;

@interface SSOBaseTableViewProvider : SSOBaseProvider <UITableViewDelegate, UITableViewDataSource>

- (instancetype)init __deprecated_msg("deprecated, use custom initializer +(instancetype)newProviderForTableView:withData:andDelegate:");

#pragma mark - Initialization

/**
 *  Create a instance of provider class with tableview, data and delegate.
 *  Set tableview delegate and datasource to the new provider instance.
 *
 *  @param tableView tableview to be handled by the provider.
 *  @param providerData array of SSProviderSection with it's data.
 *  @param delegate     delegate for provider.
 *
 *  @return instance of table view provider class
 */
+ (instancetype)newProviderForTableView:(UITableView *)tableView withData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate;
@end
