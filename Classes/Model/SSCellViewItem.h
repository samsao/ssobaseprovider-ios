//
//  SSCellViewItem.h
//  SSOBaseTableViewItem
//
//  Created by Gabriel Cartier on 2014-05-02.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

__attribute__((deprecated("Use SSOProviderItem instead.")))
@interface SSCellViewItem : NSObject

@property(strong, nonatomic) NSString *cellReusableIdentifier;
@property(strong, nonatomic) id objectData;
@property(nonatomic) CGFloat cellHeight;

@end
