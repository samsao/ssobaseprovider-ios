//
//  SSOProviderItem.h
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-09.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSOProviderItem : NSObject

@property(strong, nonatomic, readonly) NSString *cellReusableIdentifier;
@property(strong, nonatomic, readonly) NSString *cellNibName;
@property(strong, nonatomic, readonly) NSBundle *cellNibBundle;
@property(strong, nonatomic, readonly) Class cellClass;
@property(strong, nonatomic, readonly) id data;

@property(nonatomic) CGFloat cellHeight;

#pragma mark - Initialization

/**
 *  Create new SSOProviderItem with properties
 *
 *  @param data           the data
 *  @param cellReusableID the cell reusable ID
 *  @param cellNibName    the cell nib name
 *  @param nibBundle      the nib bundle
 *
 *  @return the new object
 */
+ (instancetype)newProviderItemWithData:(id)data
                     reusableIdentifier:(NSString *)cellReusableID
                            cellNibName:(NSString *)cellNibName
                          onBundleOrNil:(NSBundle *)nibBundle;

/**
 *  Create new SSOProviderItem with properties
 *
 *  @param data           the data
 *  @param cellReusableID the cell reusable ID
 *  @param cellClass      class for the cell.
 *  @param nibBundle      the nib bundle
 *
 *  @return the new object
 */
+ (instancetype)newProviderItemWithData:(id)data reusableIdentifier:(NSString *)cellReusableID cellClass:(Class)cellClass;
@end
