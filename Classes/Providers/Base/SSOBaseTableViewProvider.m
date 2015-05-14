//
//  SSOBaseTableViewProvider.m
//  Adbeus Coffee
//
//  Created by Nicolas Vincensini on 2015-01-07.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOBaseTableViewProvider.h"
#import "SSOTableViewHeaderTapGesture.h"

@implementation SSOBaseTableViewProvider

#pragma mark - UITableViewDataSource

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

    UIView *headerView;
    if (tableViewSection.customHeaderView) {
        headerView = tableViewSection.customHeaderView;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.sectionHeaderHeight)];
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
        tapgesture.sectionIndex = section;
        [headerView addGestureRecognizer:tapgesture];

        if (tableViewSection.expandImage) {
            UIImageView *expandImageView = [[UIImageView alloc] initWithImage:tableViewSection.expandImage];

            if (!CGRectIsEmpty(tableViewSection.expandImageFrame)) {
                expandImageView.frame = tableViewSection.expandImageFrame;
            } else {
                expandImageView.frame = CGRectMake(tableView.frame.size.width, 10, 40, [tableView sectionHeaderHeight] - 20);
            }

            [headerView addSubview:expandImageView];
        }
    }

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SSCellViewSection *tableViewSection = [self.inputData objectAtIndex:section];
    if (tableViewSection.customHeaderView) {
        return tableViewSection.customHeaderView.frame.size.height;
    } else if (tableViewSection.headerHeight) {
        return tableViewSection.headerHeight.floatValue;
    }
    return 0;
}

/**
 *  Expand or collapse the tapped section and reload it
 *
 *  @param tap the tapgesture
 */
- (void)collapseExpandSection:(SSOTableViewHeaderTapGesture *)tap {

    // get the section object from the custom tap
    SSCellViewSection *section = tap.section;

    NSRange range = NSMakeRange(tap.sectionIndex, 1);
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];

    section.expended = !section.expended;
    [tap.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
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
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];
    [self.delegate provider:self scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.delegate provider:self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
