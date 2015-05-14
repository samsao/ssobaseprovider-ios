//
//  SSOProviderDelegate.h
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-21.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSOProviderDelegate <NSObject>

@optional

/**
 *  Overide the tableViewDelegate/collectionViewDelegate method
 *
 *  @param provider  the provider
 *  @param indexPath the indexPath selected
 */
- (void)provider:(id)provider didSelectRowAtIndexPath:(NSIndexPath *)indexPath inView:(id)view;

/**
 *  Overide the tableViewDelegate/collectionViewDelegate method
 *
 *  @param provider  the provider
 *  @param indexPath the indexPath selected
 */
- (void)provider:(id)provider didDeselectRowAtIndexPath:(NSIndexPath *)indexPath inView:(id)view;

@end