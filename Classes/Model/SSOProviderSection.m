//
//  SSOProviderSection.m
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-09.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOProviderSection.h"
#import "SSOProviderItem.h"

@interface SSOProviderSection ()

@property(strong, nonatomic) NSMutableArray *items;

@end
@implementation SSOProviderSection

+ (instancetype)newSectionWithData:(NSArray *)sectionData {
    SSOProviderSection *section = [[SSOProviderSection alloc] init];
    if (section) {
        section.items = [NSMutableArray arrayWithArray:sectionData];
    }
    return section;
}

/**
 *  Default initializer
 *
 *  @return The object
 */
- (id)init {
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
        self.name = @"";
        self.isSearchable = NO;
        self.isExpendable = NO;
        self.expended = YES;
        self.headerHeight = 0;
        self.shouldAnimateSectionImageOnExpand = NO;
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (NSArray *)sectionItems {
    return self.items;
}

- (BOOL)addItemsToSection:(NSArray *)itemsToAdd {
    for (SSOProviderItem *item in itemsToAdd) {
        NSAssert([item isKindOfClass:[SSOProviderItem class]], @"items in the section must be of type SSOProviderItem");
        [self.items addObject:item];
    }
    return YES;
}

- (NSArray *)removeItemsFromSection:(NSArray *)itemsToRemove {
    NSMutableArray *removedIndexes = [NSMutableArray arrayWithCapacity:itemsToRemove.count];
    NSMutableArray *tempData = [NSMutableArray arrayWithArray:self.items];
    NSInteger itemIndex;
    for (SSOProviderItem *item in itemsToRemove) {
        itemIndex = [self.items indexOfObject:item];
        if (itemIndex != NSNotFound) {
            [removedIndexes addObject:@(itemIndex)];
            [tempData removeObject:item];
        }
    }
    self.items = tempData;
    return removedIndexes;
}

- (void)updateSectionDataTo:(NSArray *)newSectionData {

    for (SSOProviderItem *item in newSectionData) {
        NSAssert([item isKindOfClass:[SSOProviderItem class]], @"items in the section must be of type SSOProviderItem");
    }
    self.items = [NSMutableArray arrayWithArray:newSectionData];
}

- (BOOL)addItemToSection:(SSOProviderItem *)item atIndex:(NSInteger)index {
    if (index < self.items.count) {
        [self.items insertObject:item atIndex:index];
        return YES;
    }
    return NO;
}

@end
