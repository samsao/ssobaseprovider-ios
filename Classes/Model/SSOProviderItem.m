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

+ (instancetype)newProviderItemWithData:(id)data
                     reusableIdentifier:(NSString *)cellReusableID
                            cellNibName:(NSString *)cellNibName
                          onBundleOrNil:(NSBundle *)nibBundle {
    SSOProviderItem *item = [SSOProviderItem new];
    if (item) {
        item.cellReusableIdentifier = cellReusableID;
        item.cellNibName = cellNibName;
        item.cellNibBundle = nibBundle;
        item.data = data;
    }
    return item;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        SSOProviderItem *otherItem = object;
        return [self.data isEqual:otherItem.data];
    }
    return NO;
}

@end
