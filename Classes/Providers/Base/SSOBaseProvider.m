//
//  SSOBaseProvider.m
//
//
//  Created by Gabriel Cartier on 2015-04-14.
//
//

#import "SSOBaseProvider.h"

@interface SSOBaseProvider ()

@property(strong, nonatomic, readwrite) NSMutableArray *inputData;
+ (instancetype) new;

@end

@implementation SSOBaseProvider

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
        self.inputData = [NSMutableArray new];
    }
    return self;
}

+ (instancetype)newProviderWithData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate {
// Here we ignore the warning, since deprecation is only external to make sure the use of the proper initializer
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    SSOBaseProvider *provider = [SSOBaseProvider new];
    if (provider) {
        provider.inputData = [NSMutableArray arrayWithArray:providerData];
        provider.delegate = delegate;
    }
    return provider;
}

#pragma mark - Utilities

- (id)objectDataAtIndexPath:(NSIndexPath *)indexPath {
    SSCellViewSection *section = [self.inputData objectAtIndex:indexPath.section];
    SSCellViewItem *row = [section.rows objectAtIndex:indexPath.row];

    return row.objectData;
}

- (SSCellViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    SSCellViewSection *section = [self.inputData objectAtIndex:indexPath.section];
    SSCellViewItem *item = [section.rows objectAtIndex:indexPath.row];

    return item;
}

- (NSIndexPath *)indexPathForObject:(id)object {
    for (SSCellViewSection *section in self.inputData) {
        for (SSCellViewItem *item in section.rows) {
            if (item.objectData == object) {
                return [NSIndexPath indexPathForRow:[section.rows indexOfObject:item] inSection:[self.inputData indexOfObject:section]];
            }
        }
    }
    return nil;
}

@end
