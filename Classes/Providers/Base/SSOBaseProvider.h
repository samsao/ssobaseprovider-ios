//
//  SSOBaseProvider.h
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-14.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSOProviderCellProtocol.h"
#import "SSOProviderDelegate.h"
@class SSOProviderItem;
@class SSOProviderSection;

@interface SSOBaseProvider : NSObject

@property(weak, nonatomic, readonly) id<SSOProviderDelegate> delegate;

#pragma mark - Initialization

/**
 *  Create a instance of provider class with data and delegate
 *  Should be only used by subclasses
 *
 *  @param providerData array of SSOProviderSection with it's data.
 *  @param delegate     delegate for provider.
 *
 *  @return instance of provider class
 */

+ (instancetype)newProviderWithData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate;

/**
 *  Initialize provider with data and delegate
 *  Should be only used by subclasses
 *
 *  @param providerData array of SSOProviderSection with it's data.
 *  @param delegate     delegate for provider.
 *
 *  @return instance of provider class
 */
- (instancetype)initProviderWithData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate;

#pragma mark - Utilities

/**
 *  Get the index path for a specific object
 *
 *  @param object the object
 *
 *  @return the index path of the object
 */
- (NSIndexPath *)indexPathForObject:(id)object;
/**
 *  Set delegate to null, can be useful for race conditions on tableView or collectionView.
 */
- (void)nullifyDelegates;

#pragma mark - Getter

/**
 *  Get the cell view item from an index path. This will get the cell view item
 *
 *  @param indexPath the index path
 *
 *  @return the cell view item
 */
- (SSOProviderItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Get the section object for an index.
 *  If you're looking to add, remove or update objects, check the methods bellow:
 *      - addObjectToProviderData:inSection:
 *      - removeObjectFromProvider:inSection:
 *      - updateProviderData:inSection:
 *  @param sectionIndex index of desired section
 *
 *  @return section at index
 */
- (SSOProviderSection *)sectionAtIndex:(NSInteger)sectionIndex;

/**
 *  Get all sections for the provider.
 *
 *  @return array of SSOProviderSection
 */
- (NSArray *)allSections;

#pragma mark - Section management

/**
 *  Add new sections to the provider data.
 *
 *  @param newSections new sections to be added.
 *
 *  @return if the new sections were added or not.
 */
- (BOOL)addNewSections:(NSArray *)newSections;

/**
 *  Add new a new section to the provider data.
 *
 *  @param newSection   new section to be added to provider
 *  @param sectionIndex index of new section to be added.
 *
 *  @return if the section was added or not.
 */
- (BOOL)addNewSection:(SSOProviderSection *)newSection AtIndex:(NSInteger)sectionIndex;

/**
 *  Remove a section from the provider data at index.
 *
 *  @param sectionIndex index of the section to be removed
 *
 *  @return if the section was removed.
 */
- (BOOL)removeSectionAtIndex:(NSInteger)sectionIndex;

/**
 *  Remove sections from the provider data.
 *
 *  @param sectionsToBeRemoved sections to be removed
 *
 *  @return indexes of the removed sections.
 */
- (NSArray *)removeSections:(NSArray *)sectionsToBeRemoved;

#pragma mark - Object management

/**
 *  Add an object to provider data in a section
 *
 *  @param section section for add the object
 *  @param newObject Object to be added in provider input data
 *
 *  @return if the object was successfuly added
 */
- (BOOL)addObjectToProviderData:(id)newObject inSection:(NSInteger)section;

/**
 *  Insert a new object at a indexpath
 *
 *  @param newObject object to be inserted.
 *  @param indexPath index path to insert the object. must be a valid index in the section.
 *
 *  @return if the item was added or not in the section
 */
- (BOOL)addObject:(id)newObject atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Add an array of objects to provider data in a section optmizing the insert for multiples objects.
 *
 *  @param section section for add the objects
 *
 *  @param newObject Objects to be added to provider data
 *
 *  @return if the object was successfuly added
 */
- (BOOL)addObjectsToProviderData:(NSArray *)newObjects inSection:(NSInteger)section;

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
 *  Remove the objects from provider data in a section optmizing the deletion for multiple objects.
 *
 *  @param objectsToRemove objects to be removed from the provider
 *  @param section section to remove the objects from
 *
 *  @return array with the index of deleted objects. nil in case object does not exists in section.
 */
- (NSArray *)removeObjectsFromProvider:(NSArray *)objectsToRemove inSection:(NSInteger)section;

#pragma mark - Data management

/**
 *  Update provider data in a section
 *
 *  @param newData new input data
 *  @param section section to be updated
 *
 *  @return if the data was sucessfuly updated.
 */
- (BOOL)updateProviderData:(NSArray *)newData inSection:(NSInteger)section;

@end
