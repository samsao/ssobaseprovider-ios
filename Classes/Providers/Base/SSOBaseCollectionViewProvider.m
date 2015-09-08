//
//  SSOBaseCollectionViewProvider.m
//  Wink
//
//  Created by Gabriel Cartier on 2015-04-13.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOBaseCollectionViewProvider.h"
#import "SSCellViewSection.h"
#import "SSCellViewItem.h"

@interface SSOBaseCollectionViewProvider ()

@property(weak, nonatomic) UICollectionView *collectionView;

@end

@implementation SSOBaseCollectionViewProvider

#pragma mark - Initialization

+ (instancetype)newProviderForTableView:(UICollectionView *)collectionView withData:(NSArray *)providerData andDelegate:(id<SSOProviderDelegate>)delegate {
    SSOBaseCollectionViewProvider *provider = [super newProviderWithData:providerData andDelegate:delegate];
    if (provider) {
        collectionView.delegate = provider;
        collectionView.dataSource = provider;
        provider.collectionView = collectionView;
    }
    return provider;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self sectionAtIndex:section].rows.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.allSections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SSCellViewSection *collectionViewSection = [self sectionAtIndex:indexPath.section];
    SSCellViewItem *collectionViewElement = [collectionViewSection.rows objectAtIndex:indexPath.row];
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewElement.cellReusableIdentifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configureCell:)]) {
        [cell configureCell:collectionViewElement.objectData];
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

#pragma mark - Data

- (BOOL)addObjectToProviderData:(id)newObject inSection:(NSInteger)section {
    [super addObjectToProviderData:newObject inSection:section];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self sectionAtIndex:section].rows.count - 1 inSection:section];
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

- (BOOL)updateProviderData:(NSArray *)newData inSection:(NSInteger)section {
    if ([super updateProviderData:newData inSection:section]) {
        [self.collectionView reloadData];
        return YES;
    }
    return NO;
}

- (void)insertObject:(id)newObject atIndexPath:(NSIndexPath *)indexPath {
    [super insertObject:newObject atIndexPath:indexPath];
    [self.collectionView insertItemsAtIndexPaths:@[ indexPath ]];
}

@end
