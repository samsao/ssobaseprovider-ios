//
//  SSTableViewSection.m
//  reccard
//
//  Created by Gabriel Cartier on 2014-05-02.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "SSCellViewSection.h"

@implementation SSCellViewSection

+ (instancetype)newSectionWithData:(NSArray *)sectionData {
    SSCellViewSection *section = [[SSCellViewSection alloc] init];
    if (section) {
        section.rows = [NSMutableArray arrayWithArray:sectionData];
    }
    return section;
}

/**
 *  Default initializer
 *
 *  @return The object
 */
- (id)init {
    self = [super init];
    if (self) {
        self.rows = [[NSMutableArray alloc] init];
        self.name = @"";
        self.isSearchable = NO;
        self.isExpendable = NO;
        self.expended = YES;
        self.headerHeight = 0;
        self.shouldAnimateSectionImageOnExpand = NO;
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

@end
