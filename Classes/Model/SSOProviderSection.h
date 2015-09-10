//
//  SSOProviderSection.h
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-09.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SSOProviderItem;

@interface SSOProviderSection : NSObject

/**
 *  Create New section with objects to be displayed in this section
 *
 *  @param sectionData data for the section
 *
 *  @return instance of SSCellViewSection with data.
 */
+ (instancetype)newSectionWithData:(NSArray *)sectionData;

#pragma mark Text properties

// The name of the section. Will be displayed in a label.
@property(strong, nonatomic) NSString *name;

// The font of the label.
@property(strong, nonatomic) UIFont *font;

// The color of the label.
@property(strong, nonatomic) UIColor *textColor;

#pragma mark UI

// The background color of the section headerView.
@property(strong, nonatomic) UIColor *backgroundColor;

// It is possible to set a custom headerView.
@property(nonatomic, strong) UIView *customHeaderView;

// The height of the headerView.
@property(strong, nonatomic) NSNumber *headerHeight;

// Display an image on the right of the section if the section is expandable.
@property(nonatomic, strong) UIImage *expandImage;

// Specify a frame for the imageView.
@property(nonatomic) CGRect expandImageFrame;

#pragma mark Data

/**
 *  Array of items in the section
 *
 *  @return items contained in this section
 */
- (NSArray *)sectionItems;

/**
 *  Add an array of SSOProviderItem to the current section
 *
 *  @param itemsToAdd items to be added to section
 *
 *  @return if the items were successfuly added.
 */
- (BOOL)addItemsToSection:(NSArray *)itemsToAdd;

/**
 *  Remove an array of items from the section.
 *
 *  @param itemsToRemove items to be removed from the section
 *
 *  @return array with the indexes of the removed items.
 */
- (NSArray *)removeItemsFromSection:(NSArray *)itemsToRemove;

/**
 *  Update current section data to new data.
 *
 *  @param newSectionData array of SSOProviderItem to be set as new section data
 */
- (void)updateSectionDataTo:(NSArray *)newSectionData;

/**
 *  Add an item in the section at specific index.
 *
 *  @param item  item to be inserted
 *  @param index index to be inserted. must be a valid position in the array.
 *
 *  @return if the item as added or not to the section
 */
- (BOOL)addItemToSection:(SSOProviderItem *)item atIndex:(NSInteger)index;

// The index of the section in the tableView.
@property(nonatomic) NSInteger sectionIndex;

// NO by default.
@property(nonatomic) BOOL isSearchable;

#pragma mark Expand

// NO by default. If set to YES, the section's header become expandable on touch.
@property(nonatomic) BOOL isExpendable;

// BOOL for the state of the section. This can be used to determine if the section start expanded or not.
@property(nonatomic) BOOL expended;

// Check if the section was collapsed before making a new animation of the arrow. ** No need to use this. **
@property(nonatomic) BOOL wasCollapsed;

// Set if we want to animate the imageView in the section.
@property(nonatomic) BOOL shouldAnimateSectionImageOnExpand;

@end
