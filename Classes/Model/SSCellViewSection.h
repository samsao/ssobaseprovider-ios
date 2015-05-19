//
//  SSTableViewSection.h
//  reccard
//
//  Created by Gabriel Cartier on 2014-05-02.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSCellViewSection : NSObject

#pragma mark Text properties

// The name of the section. Will be displayed in a label.
@property(strong, nonatomic) NSString *name;

// The font of the label.
@property(strong, nonatomic) UIFont *font;

// The color of the label.
@property(strong, nonatomic) UIColor *textColor;

#pragma mark UI

// The background color of the section headerView.
@property(strong, nonatomic) UIColor *backgroundColor;

// It is possible to set a custom headerView.
@property(nonatomic, strong) UIView *customHeaderView;

// The height of the headerView.
@property(strong, nonatomic) NSNumber *headerHeight;

// Display an image on the right of the section if the section is expandable.
@property(nonatomic, strong) UIImage *expandImage;

// Specify a frame for the imageView.
@property(nonatomic) CGRect expandImageFrame;

#pragma mark Data

// A mutableArray containing the cells in the section.
@property(strong, nonatomic) NSMutableArray *rows;

// The index of the section in the tableView.
@property(nonatomic) NSInteger sectionIndex;

// NO by default.
@property(nonatomic) BOOL isSearchable;

#pragma mark Expand

// NO by default. If set to YES, the section's header become expandable on touch.
@property(nonatomic) BOOL isExpendable;

// BOOL for the state of the section. This can be used to determine if the section start expanded or not.
@property(nonatomic) BOOL expended;

// Check if the section was collapsed before making a new animation of the arrow. ** No need to use this. **
@property(nonatomic) BOOL wasCollapsed;

// Set if we want to animate the imageView in the section.
@property(nonatomic) BOOL shouldAnimateSectionImageOnExpand;

@end
