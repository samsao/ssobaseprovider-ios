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
/*!
 *  @property cellReusableIdentifier
 *
 */
@property(strong, nonatomic, readonly) NSString *cellReusableIdentifier;
@property(strong, nonatomic, readonly) NSString *cellNibName;
@property(strong, nonatomic, readonly) NSBundle *cellNibBundle;
@property(strong, nonatomic, readonly) id data;
@property(nonatomic) CGFloat cellHeight;

+ (instancetype)newProviderItemWithData:(id)data
                     reusableIdentifier:(NSString *)cellReusableID
                            cellNibName:(NSString *)cellNibName
                          onBundleOrNil:(NSBundle *)nibBundle;

@end
