//
//  SSOBaseProvider.h
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-14.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSCellViewItem.h"
#import "SSCellViewSection.h"
#import "SSBaseViewCellProtocol.h"
#import "SSOProviderDelegate.h"

@interface SSOBaseProvider : NSObject

/*! Provider data.
    Updated to readonly, if you're looking to add, remove or update objects, check the methods bellow:
    addObjectToProviderData:
    removeObjectFromProvider:
    updateProviderData: */
@property(strong, nonatomic, readonly) NSArray *inputData;
@property(weak, nonatomic) id<SSOProviderDelegate> delegate;

- (instancetype)init __deprecated_msg("Use newProviderWithData: andDelegate: instead.");
+ (instancetype) new __deprecated_msg("Use newProviderWithData: andDelegate: instead.");

/**
 *  Create a instance of provider class with data and delegate
 *
 *  @param providerData array with input data for the provider.
 *  @param delegate     delegate for provider.
 *
 *  @return instance of provider class
 */
+ (instancetype)newProviderWithData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate;

/**
 *  Get the object data from an index path. This will get the object data of an item
 *
 *  @param indexPath the index path
 *
 *  @return the object
 */
- (id)objectDataAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Get the cell view item from an index path. This will get the cell view item
 *
 *  @param indexPath the index path
 *
 *  @return the cell view item
 */
- (SSCellViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Get the index path for a specific object
 *
 *  @param object the object
 *
 *  @return the index path of the object
 */
- (NSIndexPath *)indexPathForObject:(id)object;

/**
 *  Add an object to provider input data
 *
 *  @param newObject Object to be added in provider input data
 */
- (void)addObjectToProviderData:(id)newObject;

/**
 *  Remove the object from provider input Data
 *
 *  @param objectToRemove object to be removed
 *
 *  @return if the object was successfuly removed
 */
- (BOOL)removeObjectFromProvider:(id)objectToRemove;

/**
 *  Update provider input data
 *
 *  @param newData new input data
 *
 *  @return if the data was sucessfuly updated.
 */
- (BOOL)updateProviderData:(NSArray *)newData;
@end
