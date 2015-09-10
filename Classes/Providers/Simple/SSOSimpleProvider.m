//
//  SSOSimpleProvider.m
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-21.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOSimpleProvider.h"

@implementation SSOSimpleProvider

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
        self.inputData = [NSMutableArray new];
    }
    return self;
}


@end
