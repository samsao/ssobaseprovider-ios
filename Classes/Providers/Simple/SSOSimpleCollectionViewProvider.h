//
//  SSOSimpleCollectionViewProvider.h
//  SSOBaseProvider
//
//  Created by Gabriel Cartier on 2015-04-21.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOSimpleProvider.h"
__attribute__((deprecated("Use SSOSimpleCollectionViewProvider instead.")))
@interface SSOSimpleCollectionViewProvider : SSOSimpleProvider <UICollectionViewDelegate, UICollectionViewDataSource>

@end
