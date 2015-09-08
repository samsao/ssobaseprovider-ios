//
//  SSOBaseProvider.h
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-14.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSBaseViewCellProtocol.h"
#import "SSOProviderDelegate.h"
@class SSCellViewItem;
@class SSCellViewSection;

@interface SSOBaseProvider : NSObject

@property(weak, nonatomic) id<SSOProviderDelegate> delegate;

- (instancetype)init __deprecated_msg("Use newProviderWithData: andDelegate: instead.");
+ (instancetype) new __deprecated_msg("Use newProviderWithData: andDelegate: instead.");

/**
 *  Create a instance of provider class with data and delegate
 *
 *  @param providerData array of SSCellViewSections with it's data.
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
 *  Provider data.
 *  If you're looking to add, remove or update objects, check the methods bellow:
 addObjectToProviderData:inSection:
 removeObjectFromProvider:inSection:
 updateProviderData:inSection:
 *  @param sectionIndex index of desired section
 *
 *  @return section at index
 */
- (SSCellViewSection *)sectionAtIndex:(NSInteger)sectionIndex;

/**
 *  Get all sections for the provider
 *
 *  @return array of SSCellViewSection
 */
- (NSArray *)allSections;

/**
 *  Add an object to provider data in a section
 *  @param section section for add the object
 *
 *  @param newObject Object to be added in provider input data
 *
 *  @return if the object was successfuly added
 */
- (BOOL)addObjectToProviderData:(id)newObject inSection:(NSInteger)section;

/**
 *  Remove the object from provider Data in a section
 *
 *  @param objectToRemove object to be removed
 *  @param section section to remove the object from
 *
 *  @return index of deleted object. -1 in case object does not exists in section.
 */
- (NSInteger)removeObjectFromProvider:(id)objectToRemove inSection:(NSInteger)section;

/**
 *  Update provider data in a section
 *
 *  @param newData new input data
 *  @param section section to be updated
 *
 *  @return if the data was sucessfuly updated.
 */

- (BOOL)updateProviderData:(NSArray *)newData inSection:(NSInteger)section;

/**
 *  Insert a new object in a indexpath
 *
 *  @param newObject object to be inserted.
 *  @param indexPath index path to insert the object.
 */
- (void)insertObject:(id)newObject atIndexPath:(NSIndexPath *)indexPath;
@end
