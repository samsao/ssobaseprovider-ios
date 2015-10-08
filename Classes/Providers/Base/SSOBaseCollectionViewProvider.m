//
//  SSOBaseCollectionViewProvider.m
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-13.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOBaseCollectionViewProvider.h"
#import "SSOProviderSection.h"
#import "SSOProviderItem.h"

@interface SSOBaseCollectionViewProvider ()

@property(weak, nonatomic) UICollectionView *collectionView;

@end

@implementation SSOBaseCollectionViewProvider

#pragma mark - Initialization

+ (instancetype)newProviderForTableView:(UICollectionView *)collectionView withData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate {
    SSOBaseCollectionViewProvider *provider = [[self alloc] initProviderWithData:providerData andDelegate:delegate];
    if (provider) {
        collectionView.delegate = provider;
        collectionView.dataSource = provider;
        provider.collectionView = collectionView;
    }
    return provider;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self sectionAtIndex:section].sectionItems.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.allSections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SSOProviderSection *collectionViewSection = [self sectionAtIndex:indexPath.section];
    SSOProviderItem *collectionViewElement = [collectionViewSection.sectionItems objectAtIndex:indexPath.row];

    [collectionView registerNib:[UINib nibWithNibName:collectionViewElement.cellNibName bundle:collectionViewElement.cellNibBundle]
        forCellWithReuseIdentifier:collectionViewElement.cellReusableIdentifier];
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewElement.cellReusableIdentifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configureCell:)]) {
        [cell configureCell:collectionViewElement.data];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Send message to the delegate if the method is implemented
    if ([self.delegate respondsToSelector:@selector(provider:didSelectRowAtIndexPath:inView:)]) {
        [self.delegate provider:self didSelectRowAtIndexPath:indexPath inView:collectionView];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Send message to the delegate if the method is implemented
    if ([self.delegate respondsToSelector:@selector(provider:didDeselectRowAtIndexPath:inView:)]) {
        [self.delegate provider:self didDeselectRowAtIndexPath:indexPath inView:collectionView];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(provider:scrollViewDidScroll:)]) {
        // we need to fire the scrollViewDidEndScrollingAnimation because it's not always called.
        [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];
        [self.delegate provider:self scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(provider:scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate provider:self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

#pragma mark - Object management

- (BOOL)addObjectToProviderData:(id)newObject inSection:(NSInteger)section {
    [super addObjectToProviderData:newObject inSection:section];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self sectionAtIndex:section].sectionItems.count - 1 inSection:section];
    [self.collectionView insertItemsAtIndexPaths:@[ indexPath ]];
    return YES;
}

- (NSInteger)removeObjectFromProvider:(id)objectToRemove inSection:(NSInteger)section {
    NSInteger removedIndex = [super removeObjectFromProvider:objectToRemove inSection:section];
    NSIndexPath *deleteIndex = [NSIndexPath indexPathForRow:removedIndex inSection:section];
    if (deleteIndex >= 0) {
        [self.collectionView deleteItemsAtIndexPaths:@[ deleteIndex ]];
        return YES;
    }
    return NO;
}

- (BOOL)addObject:(id)newObject atIndexPath:(NSIndexPath *)indexPath {
    BOOL wasInserted = [super addObject:newObject atIndexPath:indexPath];
    if (wasInserted) {
        [self.collectionView insertItemsAtIndexPaths:@[ indexPath ]];
        return YES;
    }
    return NO;
}

- (BOOL)addObjectsToProviderData:(NSArray *)newObjects inSection:(NSInteger)section {
    if ([super addObjectsToProviderData:newObjects inSection:section]) {
        SSOProviderSection *dataSection = [self sectionAtIndex:section];
        NSInteger rowIndex = dataSection.sectionItems.count - newObjects.count;
        NSIndexPath *indexPath;
        NSMutableArray *indexesArray = [NSMutableArray arrayWithCapacity:newObjects.count];
        for (; rowIndex < dataSection.sectionItems.count; rowIndex++) {
            indexPath = [NSIndexPath indexPathForItem:rowIndex inSection:section];
            [indexesArray addObject:indexPath];
        }
        [self.collectionView insertItemsAtIndexPaths:indexesArray];

        return YES;
    }
    return NO;
}

- (NSArray *)removeObjectsFromProvider:(NSArray *)objectsToRemove inSection:(NSInteger)section {
    NSArray *removedIndexes = [super removeObjectsFromProvider:objectsToRemove inSection:section];
    if (removedIndexes) {
        NSMutableArray *indexPathsToRemove = [NSMutableArray arrayWithCapacity:objectsToRemove.count];
        NSIndexPath *indexPath;
        for (NSNumber *removedIndex in removedIndexes) {
            indexPath = [NSIndexPath indexPathForRow:removedIndex.integerValue inSection:section];
            [indexPathsToRemove addObject:indexPath];
        }
        [self.collectionView deleteItemsAtIndexPaths:indexPathsToRemove];
    }
    return removedIndexes;
}

#pragma mark - Section management

/**
 *  Private Method.
 *  Remove sections from table view at indexes
 *
 *  @param indexes indexes of the sections to be deleted from tableview.
 */
- (void)removeSectionInCollectionViewAtIndexes:(NSArray *)indexes withCompletionBlock:(void (^)(BOOL finished))completion {

    [self.collectionView performBatchUpdates:^{
      for (NSNumber *index in indexes) {
          [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:index.integerValue]];
      }
    } completion:completion];
}

- (BOOL)addNewSections:(NSArray *)newSections {
    NSRange range = NSMakeRange(self.allSections.count, newSections.count);
    BOOL wasAdded = [super addNewSections:newSections];
    if (wasAdded) {
        [self.collectionView insertSections:[NSIndexSet indexSetWithIndexesInRange:range]];
    }
    return wasAdded;
}
- (BOOL)addNewSection:(SSOProviderSection *)newSection AtIndex:(NSInteger)sectionIndex {
    BOOL wasAdded = [super addNewSection:newSection AtIndex:sectionIndex];
    if (wasAdded) {
        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
    }
    return wasAdded;
}

- (BOOL)removeSectionAtIndex:(NSInteger)sectionIndex {
    if ([super removeSectionAtIndex:sectionIndex]) {
        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
        return YES;
    }
    return NO;
}

- (NSArray *)removeSections:(NSArray *)sectionsToBeRemoved {
    @throw [NSException exceptionWithName:@"Wrong method" reason:@"Use removeSections: withCompletionBlock: instead." userInfo:nil];
}

- (NSArray *)removeSections:(NSArray *)sectionsToBeRemoved withCompletionBlock:(void (^)(NSArray *removedIndexes))completion {
    NSArray *removedIndexes = [super removeSections:sectionsToBeRemoved];
    if (removedIndexes) {
        [self removeSectionInCollectionViewAtIndexes:removedIndexes
                                 withCompletionBlock:^(BOOL finished) {
                                   completion(removedIndexes);
                                 }];
    }
    return removedIndexes;
}

#pragma mark - Utilities

- (BOOL)updateProviderData:(NSArray *)newData inSection:(NSInteger)section {
    if ([super updateProviderData:newData inSection:section]) {
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
        return YES;
    }
    return NO;
}

@end
