//
//  SSOBaseCollectionViewProvider.h
//  Wink
//
//  Created by Gabriel Cartier on 2015-04-13.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSOBaseProvider.h"

@interface SSOBaseCollectionViewProvider : SSOBaseProvider <UICollectionViewDelegate, UICollectionViewDataSource>

/**
 *  Create a instance of provider class with a collection view, data and delegate.
 *  Set collection view delegate and datasource to the new provider instance.
 *
 *  @param collectionView collectionView to be handled by the provider.
 *  @param providerData array of SSOProviderSection with it's data.
 *  @param delegate     delegate for provider.
 *
 *  @return instance of table view provider class
 */
+ (instancetype)newProviderForTableView:(UICollectionView *)collectionView withData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate;

@end
