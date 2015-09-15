//
//  SSOBaseProviderSpec.m
//  SSOBaseProvider
//
//  Created by Guilherme Silva Lisboa on 2015-09-14.
//  Copyright (c) 2015 Samsao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Specta/Specta.h>
#import <Expecta.h>
#import "SSOBaseProvider.h"
#import "SSOProviderItem.h"
#import "SSOProviderSection.h"
#import "SSOTestModel.h"

NSString *const kTestRI = @"";
NSString *const kTestNib = @"";

SpecBegin(SSOBaseProvider)
describe(@"Base Provider", ^{
    // Creating Data
    
    SSOTestModel *td = [SSOTestModel new];
    
    SSOProviderItem *pi = [SSOProviderItem newProviderItemWithData:td reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
    SSOProviderSection *providerSection = [SSOProviderSection newSectionWithData:@[ pi ]];
    
    SSOBaseProvider *provider = [SSOBaseProvider newProviderWithData:@[ providerSection ] andDelegate:nil];
    
    expect(provider).toNot.beNil();
    expect(provider).toNot.beNull();
    
    context(@"Insertion", ^{
        
        it(@"Add objects", ^{
            SSOTestModel *m1 = [SSOTestModel new];
            SSOTestModel *m2 = [SSOTestModel new];
            SSOTestModel *m3 = [SSOTestModel new];
            
            SSOProviderItem *a = [SSOProviderItem newProviderItemWithData:m1 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
            SSOProviderItem *b = [SSOProviderItem newProviderItemWithData:m2 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
            SSOProviderItem *c = [SSOProviderItem newProviderItemWithData:m3 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
            NSInteger section = 0;
            NSArray *data = @[ a, b ];
            
            BOOL wasAdded = [provider addObjectsToProviderData:data inSection:section];
            SSOProviderSection *currentSection = provider.allSections[section];
            if (wasAdded) {
                expect(currentSection.sectionItems).to.contain(a);
                expect(currentSection.sectionItems).to.contain(b);
            } else {
                expect(currentSection.sectionItems).toNot.contain(a);
                expect(currentSection.sectionItems).toNot.contain(b);
            }
            
            NSInteger indexToAdd = 0;
            wasAdded = [provider addObject:c atIndexPath:[NSIndexPath indexPathForRow:indexToAdd inSection:section]];
            if (wasAdded) {
                expect(currentSection.sectionItems).to.contain(c);
                expect([provider sectionAtIndex:section].sectionItems[indexToAdd]).to.equal(c);
            } else {
                expect(currentSection.sectionItems).toNot.contain(c);
            }
        });
        
        it(@"remove objects", ^{
            SSOTestModel *m1 = [SSOTestModel new];
            SSOTestModel *m2 = [SSOTestModel new];
            SSOTestModel *m3 = [SSOTestModel new];
            
            SSOProviderItem *a = [SSOProviderItem newProviderItemWithData:m1 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
            SSOProviderItem *b = [SSOProviderItem newProviderItemWithData:m2 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
            SSOProviderItem *c = [SSOProviderItem newProviderItemWithData:m3 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
            
            NSInteger section = 0;
            NSArray *data = @[ a, b, c ];
            [provider addObjectsToProviderData:data inSection:section];
            
            NSArray *removedIndexes = [provider removeObjectsFromProvider:data inSection:section];
            if (removedIndexes) {
                expect(provider.allSections[section]).toNot.contain(a);
                expect(provider.allSections[section]).toNot.contain(b);
                expect(provider.allSections[section]).to.contain(c);
            } else {
                expect(provider.allSections[section]).to.contain(a);
                expect(provider.allSections[section]).to.contain(b);
                expect(provider.allSections[section]).to.contain(c);
            }
            
            NSInteger removedIndex = [provider removeObjectFromProvider:c inSection:section];
            if (removedIndex) {
                expect(provider.allSections[section]).toNot.contain(c);
            } else {
                expect(provider.allSections[section]).to.contain(c);
            }
            
        });
        
    });
});
SpecEnd
