//
//  SSOBaseCollectionViewProvider.m
//  Wink
//
//  Created by Gabriel Cartier on 2015-04-13.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOBaseCollectionViewProvider.h"

@implementation SSOBaseCollectionViewProvider

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (![[self.inputData objectAtIndex:section] isKindOfClass:[SSCellViewSection class]]) {
        // Should not happen, means it's not a proper object
        return 0;
    }
    SSCellViewSection *collectionViewSection = [self.inputData objectAtIndex:section];

    return [collectionViewSection.rows count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.inputData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SSCellViewSection *collectionViewSection = [self.inputData objectAtIndex:indexPath.section];
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

@end
