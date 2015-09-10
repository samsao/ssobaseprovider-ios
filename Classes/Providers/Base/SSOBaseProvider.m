//
//  SSOBaseProvider.m
//
//
//  Created by Gabriel Cartier on 2015-04-14.
//
//

#import "SSOBaseProvider.h"
#import "SSOProviderItem.h"
#import "SSOProviderSection.h"

@interface SSOBaseProvider ()

@property(strong, nonatomic, readwrite) NSMutableArray *sections;
@property(weak, nonatomic, readwrite) id<SSOProviderDelegate> delegate;

@end

@implementation SSOBaseProvider

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
        self.sections = [NSMutableArray new];
    }
    return self;
}
+ (instancetype) new {
    return [[SSOBaseProvider alloc] init];
}

+ (instancetype)newProviderWithData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate {

    // Looping trough all items in array to check if they're of SSOProviderSection Type.
    for (SSOProviderSection *section in providerData) {
        NSAssert(([section isKindOfClass:[SSOProviderSection class]]), @"providerData should be an array of SSOProviderSection.");
    }

// Here we ignore the warning, since deprecation is only external to make sure the use of the proper initializer
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    SSOBaseProvider *provider = [SSOBaseProvider new];
    if (provider) {
        provider.sections = [NSMutableArray arrayWithArray:providerData];
        provider.delegate = delegate;
    }
    return provider;
}

- (instancetype)initProviderWithData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate {

    // Looping trough all items in array to check if they're of SSOProviderSection Type.
    for (SSOProviderSection *section in providerData) {
        NSAssert(([section isKindOfClass:[SSOProviderSection class]]), @"providerData should be an array of SSOProviderSection.");
    }

// Here we ignore the warning, since deprecation is only external to make sure the use of the proper initializer
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    self = [super init];
    if (self) {
        self.sections = [NSMutableArray arrayWithArray:providerData];
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - Utilities

- (SSOProviderItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    SSOProviderSection *section = [self.sections objectAtIndex:indexPath.section];
    SSOProviderItem *item = [section.sectionItems objectAtIndex:indexPath.row];

    return item;
}

- (NSIndexPath *)indexPathForObject:(id)object {
    for (SSOProviderSection *section in self.sections) {
        for (SSOProviderItem *item in section.sectionItems) {
            if (item.data == object) {
                return [NSIndexPath indexPathForRow:[section.sectionItems indexOfObject:item] inSection:[self.sections indexOfObject:section]];
            }
        }
    }
    return nil;
}

#pragma mark - Getter

- (SSOProviderSection *)sectionAtIndex:(NSInteger)sectionIndex {
    return [self.sections objectAtIndex:sectionIndex];
}

- (NSArray *)allSections {
    return self.sections;
}

#pragma mark - Data

- (BOOL)addObjectToProviderData:(id)newObject inSection:(NSInteger)section {
    NSInteger sectionsAmt = self.sections.count;
    if (sectionsAmt > section) {
        SSOProviderSection *dataSection = [self.sections objectAtIndex:section];
        return [dataSection addItemsToSection:@[ newObject ]];
    }
    return NO;
}

- (NSInteger)removeObjectFromProvider:(id)objectToRemove inSection:(NSInteger)section {
    NSInteger removedIndex = -1;
    if (self.sections.count > section) {
        SSOProviderSection *dataSection = [self.sections objectAtIndex:section];
        NSArray *indexes = [dataSection removeItemsFromSection:@[ objectToRemove ]];
        if (indexes) {
            NSNumber *value = indexes.firstObject;
            return value.integerValue;
        }
    }
    return removedIndex;
}

- (BOOL)updateProviderData:(NSArray *)newData inSection:(NSInteger)section {

    if (self.sections.count > section) {
        SSOProviderSection *dataSection = [self.sections objectAtIndex:section];
        [dataSection updateSectionDataTo:newData];
        return YES;
    }

    return NO;
}

- (BOOL)addObject:(id)newObject atIndexPath:(NSIndexPath *)indexPath {
    if (self.sections.count > indexPath.section) {
        SSOProviderSection *section = self.sections[indexPath.section];
        return [section addItemToSection:newObject atIndex:indexPath.row];
    }
    return NO;
}

- (BOOL)addObjectsToProviderData:(NSArray *)newObjects inSection:(NSInteger)section {
    if (self.sections.count > section) {
        SSOProviderSection *dataSection = [self.sections objectAtIndex:section];
        [dataSection addItemsToSection:newObjects];
        return YES;
    }
    return NO;
}

- (NSArray *)removeObjectsFromProvider:(NSArray *)objectsToRemove inSection:(NSInteger)section {
    NSArray *removedIndexes;
    if (self.sections.count > section) {
        removedIndexes = [NSMutableArray arrayWithCapacity:objectsToRemove.count];
        SSOProviderSection *dataSection = [self.sections objectAtIndex:section];
        removedIndexes = [dataSection removeItemsFromSection:objectsToRemove];
    }
    return removedIndexes;
}

@end
