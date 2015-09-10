//
//  SSOProviderCellProtocol.h
//  Kwirk
//
//  Created by Nicolas VINCENSINI on 2014-07-30.
//  Copyright (c) 2014 Kwirk Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SSOProviderItem;

@protocol SSOProviderCellProtocol

@required
- (void)configureCell:(id)cellData;

@end
