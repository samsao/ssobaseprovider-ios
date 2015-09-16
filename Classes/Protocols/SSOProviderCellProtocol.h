//
//  SSOProviderCellProtocol.h
//  SSOBaseProvider
//
//  Created by Nicolas VINCENSINI on 2014-07-30.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SSOProviderItem;

@protocol SSOProviderCellProtocol

@required
/**
 *  Called everytime a cell is dequeued. This is where the logic of the view should be done
 *
 *  @param cellData the cell data
 */
- (void)configureCell:(id)cellData;

@end
