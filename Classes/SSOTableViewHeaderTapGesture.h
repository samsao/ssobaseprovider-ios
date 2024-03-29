//
//  SSOTableViewHeaderTapGesture.h
//  Adbeus Coffee
//
//  Created by Nicolas Vincensini on 2015-05-13.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCellViewSection.h"

@interface SSOTableViewHeaderTapGesture : UITapGestureRecognizer

@property(nonatomic, strong) SSCellViewSection *section;
@property(nonatomic) NSInteger sectionIndex;
@property(nonatomic, strong) NSArray *rows;
@property(nonatomic, strong) UITableView *tableView;

@end
