//
//  SSOSimpleCollectionViewProvider.m
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-21.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOSimpleCollectionViewProvider.h"
#import "SSOProviderCellProtocol.h"

@implementation SSOSimpleCollectionViewProvider

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.inputData count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell<SSOProviderCellProtocol> *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:self.cellReusableIdentifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configureCell:)]) {
        [cell configureCell:[self.inputData objectAtIndex:indexPath.row]];
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
