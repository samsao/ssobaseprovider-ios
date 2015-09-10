//
//  SSOTestCollectionCell.m
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-10.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOTestCollectionCell.h"
#import "SSOProviderCellProtocol.h"
#import "SSOTestModel.h"

@interface SSOTestCollectionCell () <SSOProviderCellProtocol>
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation SSOTestCollectionCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configureCell:(id)cellData {
    if ([cellData isKindOfClass:[SSOTestModel class]]) {
        SSOTestModel *test = cellData;
        self.nameLabel.text = test.namingString;
    }
}

@end
