//
//  SSOProviderItem.m
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-09.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOProviderItem.h"

@interface SSOProviderItem ()

@property(strong, nonatomic, readwrite) NSString *cellReusableIdentifier;
@property(strong, nonatomic, readwrite) NSString *cellNibName;
@property(strong, nonatomic, readwrite) NSBundle *cellNibBundle;
@property(strong, nonatomic, readwrite) id data;

@end

@implementation SSOProviderItem

#pragma mark - Initialization

+ (instancetype)newProviderItemWithData:(id)data
                     reusableIdentifier:(NSString *)cellReusableID
                            cellNibName:(NSString *)cellNibName
                          onBundleOrNil:(NSBundle *)nibBundle {
    SSOProviderItem *item = [SSOProviderItem new];
    if (item) {
        NSAssert(cellReusableID != nil, @"cellReusableID should not be nil.");
        item.cellReusableIdentifier = cellReusableID;
        NSAssert(cellNibName != nil, @"cellNibName should not be nil.");
        item.cellNibName = cellNibName;
        item.cellNibBundle = nibBundle;
        item.data = data;
    }
    return item;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        SSOProviderItem *otherItem = object;
        // Check if both data of items are equal.
        // Since data is an id, it will always work, the object should have it's own isEqual to work perfectly, otherwise it checks
        // the memory address.
        return [self.data isEqual:otherItem.data];
    }
    return NO;
}

@end
