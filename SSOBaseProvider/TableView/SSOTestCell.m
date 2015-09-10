//
//  SSOTestCell.m
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-09.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import "SSOTestCell.h"
#import "SSOProviderCellProtocol.h"
#import "SSOTestModel.h"

@interface SSOTestCell () <SSOProviderCellProtocol>
@property(strong, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation SSOTestCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(id)cellData {
    if ([cellData isKindOfClass:[SSOTestModel class]]) {
        SSOTestModel *data = cellData;
        self.testLabel.text = data.namingString;
    }
}

@end
