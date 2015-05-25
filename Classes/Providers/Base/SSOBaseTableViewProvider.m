//
//  SSOBaseTableViewProvider.m
//  Adbeus Coffee
//
//  Created by Nicolas Vincensini on 2015-01-07.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOBaseTableViewProvider.h"
#import "SSOTableViewHeaderTapGesture.h"

@interface SSOBaseTableViewProvider ()

// MutableArray used to store the state of the section. This is the only option that worked until now. Trying to pass this to the section also failed.
@property(nonatomic, strong) NSMutableArray *arrayAnimationState;

@end

@implementation SSOBaseTableViewProvider

#pragma mark - UITableViewDataSource

- (instancetype)init {

    if (self = [super init]) {

        self.arrayAnimationState = [NSMutableArray new];

        return self;
    }

    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![[self.inputData objectAtIndex:section] isKindOfClass:[SSCellViewSection class]]) {
        // Should not happen, means it's not a proper object
        return 0;
    }
    SSCellViewSection *tableViewSection = [self.inputData objectAtIndex:section];
    if (tableViewSection.expended) {
        return [tableViewSection.rows count];
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.inputData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSCellViewSection *tableViewSection = [self.inputData objectAtIndex:indexPath.section];
    SSCellViewItem *tableViewElement = [tableViewSection.rows objectAtIndex:indexPath.row];
    id cell = [tableView dequeueReusableCellWithIdentifier:tableViewElement.cellReusableIdentifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configureCell:)]) {
        [cell configureCell:tableViewElement.objectData];
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSCellViewSection *tableViewSection = [self.inputData objectAtIndex:indexPath.section];
    SSCellViewItem *tableViewElement = [tableViewSection.rows objectAtIndex:indexPath.row];

    if (tableViewElement.cellHeight) {
        return tableViewElement.cellHeight;
    }

    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    SSCellViewSection *tableViewSection = [self.inputData objectAtIndex:section];

    if (section >= self.arrayAnimationState.count) {
        [self.arrayAnimationState addObject:@(tableViewSection.expended)];
    }

    UIView *headerView;
    if (tableViewSection.customHeaderView) {
        headerView = tableViewSection.customHeaderView;
    } else {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableViewSection.headerHeight.floatValue)];
        headerView.backgroundColor = tableViewSection.backgroundColor;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 320, 30)];
        label.text = tableViewSection.name;
        label.textColor = tableViewSection.textColor;
        label.font = tableViewSection.font;
        [headerView addSubview:label];
    }

    // If the section is expandable add a gesture recognizer to allow expand/collapse of the section and also add an image on the right of the header to show
    // that it's expandable
    if (tableViewSection.isExpendable) {
        SSOTableViewHeaderTapGesture *tapgesture = [[SSOTableViewHeaderTapGesture alloc] initWithTarget:self action:@selector(collapseExpandSection:)];
        tapgesture.section = tableViewSection;
        tapgesture.tableView = tableView;

        // Check if the section has an image
        if (tableViewSection.expandImage) {

            // Init the imageView
            UIImageView *expandImageView = [[UIImageView alloc] initWithImage:tableViewSection.expandImage];

            // Check if the section has a frame for the imageView
            if (!CGRectIsEmpty(tableViewSection.expandImageFrame)) {
                // If YES, set the frame to the imageView
                expandImageView.frame = tableViewSection.expandImageFrame;
            } else {
                // If NO, set a basic frame for the imageView
                expandImageView.frame = CGRectMake(tableView.frame.size.width - tableViewSection.headerHeight.floatValue / 3 - 10, 10,
                                                   tableViewSection.headerHeight.floatValue / 4, tableViewSection.headerHeight.floatValue / 4);
                // Center Y of the imageView with the center of the header
                expandImageView.center = CGPointMake(expandImageView.center.x, headerView.center.y);
            }

            // TODO: I don't like these 2 consecutives if. There must be a way to refactor it.
            // Check if we want to an imate
            if (tableViewSection.shouldAnimateSectionImageOnExpand) {

                // Check if the section was collapsed before displaying the image
                if ([self.arrayAnimationState[section] boolValue]) {
                    expandImageView.transform = CGAffineTransformMakeRotation(0);
                } else {
                    expandImageView.transform = CGAffineTransformMakeRotation(M_PI);
                }
            }
            // Add the imageView to the header
            [headerView addSubview:expandImageView];

            // Check if we want to an imate
            if (tableViewSection.shouldAnimateSectionImageOnExpand) {

                // Once we have added the imageView, we have to rotate it depending if the section is expanded or not
                dispatch_async(dispatch_get_main_queue(), ^{
                  [self animateImageView:expandImageView forHeaderInSection:tableViewSection];

                });
            }
        }
        // Add the tapGesture to the header
        [headerView addGestureRecognizer:tapgesture];
    }

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SSCellViewSection *tableViewSection = [self.inputData objectAtIndex:section];
    // If the section has a customView, set the height of the header to the height of the view
    if (tableView.numberOfSections == 1 && [self tableView:tableView numberOfRowsInSection:section] == 0) {
        return 0;
    }

    if (tableViewSection.customHeaderView) {
        return tableViewSection.customHeaderView.frame.size.height;
    }
    // If we are passing a height for the header.
    else if (tableViewSection.headerHeight) {
        return tableViewSection.headerHeight.floatValue;
    }
    // We shouldn't arrive here except if we have no header
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Send message to the delegate if the method is implemented
    if ([self.delegate respondsToSelector:@selector(provider:didSelectRowAtIndexPath:inView:)]) {
        [self.delegate provider:self didSelectRowAtIndexPath:indexPath inView:tableView];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Send message to the delegate if the method is implemented
    if ([self.delegate respondsToSelector:@selector(provider:didDeselectRowAtIndexPath:inView:)]) {
        [self.delegate provider:self didDeselectRowAtIndexPath:indexPath inView:tableView];
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

#pragma mark - Utilities

/**
 *  Expand or collapse the tapped section and reload it
 *
 *  @param tap the tapgesture
 */
- (void)collapseExpandSection:(SSOTableViewHeaderTapGesture *)tap {

    // get the section object from the custom tap
    SSCellViewSection *section = tap.section;

    NSRange range = NSMakeRange(section.sectionIndex, 1);
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];

    section.expended = !section.expended;

    [tap.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}

/**
 *  Animate the rotation of the imageView in the header when the section expand/collapse
 *
 *  @param imageView the imageView
 *  @param section   the section
 */
- (void)animateImageView:(UIImageView *)imageView forHeaderInSection:(SSCellViewSection *)section {

    CABasicAnimation *rotate;
    rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    // TODO: Maybe we should pass the duration as a parameter
    rotate.duration = 0.3;
    rotate.repeatCount = 1;
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = NO;

    if ([self.arrayAnimationState[section.sectionIndex] boolValue] == section.expended) {
        return;
    }

    self.arrayAnimationState[section.sectionIndex] = @(section.expended);

    if (section.expended) {
        rotate.toValue = [NSNumber numberWithFloat:0];
    } else {
        rotate.toValue = [NSNumber numberWithFloat:M_PI];
    }
    [imageView.layer addAnimation:rotate forKey:@"10"];
}

@end
