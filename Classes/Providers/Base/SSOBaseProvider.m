//
//  SSOBaseProvider.m
//
//
//  Created by Gabriel Cartier on 2015-04-14.
//
//

#import "SSOBaseProvider.h"
#import "SSCellViewItem.h"
#import "SSCellViewSection.h"

@interface SSOBaseProvider ()

@property(strong, nonatomic, readwrite) NSMutableArray *sections;

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

    // Looping trough all items in array to check if they're of SSCellViewSection Type.
    for (SSCellViewSection *section in providerData) {
        NSAssert(![section isKindOfClass:[SSCellViewSection class]], @"providerData should be an array of SSCellViewSection.");
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

#pragma mark - Utilities

- (id)objectDataAtIndexPath:(NSIndexPath *)indexPath {
    SSCellViewSection *section = [self.sections objectAtIndex:indexPath.section];
    SSCellViewItem *row = [section.rows objectAtIndex:indexPath.row];

    return row.objectData;
}

- (SSCellViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    SSCellViewSection *section = [self.sections objectAtIndex:indexPath.section];
    SSCellViewItem *item = [section.rows objectAtIndex:indexPath.row];

    return item;
}

- (NSIndexPath *)indexPathForObject:(id)object {
    for (SSCellViewSection *section in self.sections) {
        for (SSCellViewItem *item in section.rows) {
            if (item.objectData == object) {
                return [NSIndexPath indexPathForRow:[section.rows indexOfObject:item] inSection:[self.sections indexOfObject:section]];
            }
        }
    }
    return nil;
}

#pragma mark - Getter

- (SSCellViewSection *)sectionAtIndex:(NSInteger)sectionIndex {
    return [self.sections objectAtIndex:sectionIndex];
}

- (NSArray *)allSections {
    return self.sections;
}

#pragma mark - Data

- (BOOL)addObjectToProviderData:(id)newObject inSection:(NSInteger)section {
    NSInteger sectionsAmt = self.sections.count;
    if (sectionsAmt < section) {
        SSCellViewSection *dataSection = [self.sections objectAtIndex:section];
        [dataSection.rows addObject:newObject];
        return YES;
    }
    return NO;
}

- (NSInteger)removeObjectFromProvider:(id)objectToRemove inSection:(NSInteger)section {
    NSInteger removedIndex = -1;
    if (self.sections.count < section) {
        SSCellViewSection *dataSection = [self.sections objectAtIndex:section];
        if ([dataSection.rows containsObject:objectToRemove]) {
            removedIndex = [dataSection.rows indexOfObject:objectToRemove];
            [dataSection.rows removeObject:objectToRemove];
        }
    }
    return removedIndex;
}

- (BOOL)updateProviderData:(NSArray *)newData inSection:(NSInteger)section {

    if (self.sections.count < section) {
        SSCellViewSection *dataSection = [self.sections objectAtIndex:section];
        dataSection.rows = [NSMutableArray arrayWithArray:newData];
        return YES;
    }

    return NO;
}

- (void)insertObject:(id)newObject atIndexPath:(NSIndexPath *)indexPath {
    if (self.sections.count <= indexPath.section) {
        SSCellViewSection *section = self.sections[indexPath.section];
        if (section.rows.count <= indexPath.row) {
            [section.rows insertObject:newObject atIndex:indexPath.row];
        } else {
            [section.rows addObject:newObject];
        }
    }
}

@end
