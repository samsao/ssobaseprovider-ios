//
//  SSOSimpleTableViewProvider.h
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-21.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOSimpleProvider.h"

__attribute__((deprecated("Use SSOSimpleTableViewProvider instead.")))
@interface SSOSimpleTableViewProvider : SSOSimpleProvider<UITableViewDelegate, UITableViewDataSource>

@end
