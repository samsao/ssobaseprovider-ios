//
//  SSONoNibCell.m
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-11-26.
//  Copyright © 2015 Samsao. All rights reserved.
//

#import "SSONoNibCell.h"
#import "SSOProviderCellProtocol.h"
#import "SSOTestModel.h"

@interface SSONoNibCell () <SSOProviderCellProtocol>
@property(strong, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation SSONoNibCell

- (instancetype)init {
    self = [super init];
    if (self) {
        UILabel *label = [UILabel new];
        self.testLabel = label;
        [self addSubview:label];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                          constant:0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
    }
    return self;
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
