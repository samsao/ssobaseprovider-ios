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
#import <OCMock.h>
#import "SSOBaseProvider.h"
#import "SSOProviderItem.h"
#import "SSOProviderSection.h"
#import "SSOTestModel.h"

NSString *const kTestRI = @"";
NSString *const kTestNib = @"";

SpecBegin(SSOBaseProvider)
    //     describe(@"Base Provider", ^{
    //      // Creating Data
    //
    //      SSOTestModel *td = [SSOTestModel new];
    //
    //      SSOProviderItem *pi = [SSOProviderItem newProviderItemWithData:td reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
    //      SSOProviderSection *providerSection = [SSOProviderSection newSectionWithData:@[ pi ]];
    //
    //      SSOBaseProvider *provider = [SSOBaseProvider newProviderWithData:@[ providerSection ] andDelegate:nil];
    //
    //      expect(provider).toNot.beNil();
    //      expect(provider).toNot.beNull();
    //
    //      context(@"Insertion", ^{
    //
    //        SSOTestModel *m1 = [SSOTestModel new];
    //        SSOTestModel *m2 = [SSOTestModel new];
    //        SSOTestModel *m3 = [SSOTestModel new];
    //
    //        SSOProviderItem *a = [SSOProviderItem newProviderItemWithData:m1 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
    //        SSOProviderItem *b = [SSOProviderItem newProviderItemWithData:m2 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
    //        SSOProviderItem *c = [SSOProviderItem newProviderItemWithData:m3 reusableIdentifier:kTestRI cellNibName:kTestNib onBundleOrNil:nil];
    //        NSInteger section = 0;
    //        SSOProviderSection *currentSection = provider.allSections[section];
    //
    //        it(@"Add objects", ^{
    //          NSArray *data = @[ a, b ];
    //
    //          BOOL wasAdded = [provider addObjectsToProviderData:data inSection:section];
    //          if (wasAdded) {
    //              expect(currentSection.sectionItems).to.contain(a);
    //              expect(currentSection.sectionItems).to.contain(b);
    //          } else {
    //              expect(currentSection.sectionItems).toNot.contain(a);
    //              expect(currentSection.sectionItems).toNot.contain(b);
    //          }
    //
    //    });
    //    it(@"Add object at index", ^{
    //      NSInteger indexToAdd = 0;
    //      BOOL wasAdded = [provider addObject:c atIndexPath:[NSIndexPath indexPathForRow:indexToAdd inSection:section]];
    //      if (wasAdded) {
    //          expect(currentSection.sectionItems).to.contain(c);
    //          expect([provider sectionAtIndex:section].sectionItems[indexToAdd]).to.equal(c);
    //      } else {
    //          expect(currentSection.sectionItems).toNot.contain(c);
    //      }
    //    });
    //
    //    it(@"remove objects", ^{
    //      NSArray *data = @[ a, b ];
    //      [provider addObjectsToProviderData:data inSection:section];
    //
    //      NSArray *removedIndexes = [provider removeObjectsFromProvider:data inSection:section];
    //      if (removedIndexes) {
    //          expect(currentSection.sectionItems).toNot.contain(a);
    //          expect(currentSection.sectionItems).toNot.contain(b);
    //          expect(currentSection.sectionItems).to.contain(c);
    //      } else {
    //          expect(currentSection.sectionItems).to.contain(a);
    //          expect(currentSection.sectionItems).to.contain(b);
    //          expect(currentSection.sectionItems).to.contain(c);
    //      }
    //
    //    });
    //    it(@"Remove single object", ^{
    //      NSInteger removedIndex = [provider removeObjectFromProvider:c inSection:section];
    //      if (removedIndex != -1) {
    //          expect(currentSection.sectionItems).toNot.contain(c);
    //      } else {
    //          expect(currentSection.sectionItems).to.contain(c);
    //      }
    //    });
    //#warning TODO: ADD Test for ADD/Remove Sections
    //  });
    //});

    describe(@"Base Provider", ^{
      // Creating Data

      SSOProviderItem *pi = OCMClassMock([SSOProviderItem class]);

      SSOProviderSection *providerSection = OCMClassMock([SSOProviderSection class]);
      OCMStub([providerSection sectionItems]).andReturn(@[ pi ]);

      SSOBaseProvider *provider = [SSOBaseProvider newProviderWithData:@[ providerSection ] andDelegate:nil];

      expect(provider).toNot.beNil();
      expect(provider).toNot.beNull();

      context(@"Insertion", ^{

        SSOProviderItem *a = OCMClassMock([SSOProviderItem class]);
        SSOProviderItem *b = OCMClassMock([SSOProviderItem class]);
        SSOProviderItem *c = OCMClassMock([SSOProviderItem class]);
        NSInteger sectionIndex = 0;
        NSArray *data = @[ a, b ];

        it(@"Add objects", ^{

          OCMStub([providerSection addItemsToSection:data]).andReturn(YES);

          BOOL wasAdded = [provider addObjectsToProviderData:data inSection:sectionIndex];

          expect(wasAdded).to.beTruthy();
          OCMVerify([providerSection addItemsToSection:data]);

          wasAdded = [provider addObjectsToProviderData:data inSection:-1];

          expect(wasAdded).to.beFalsy();

        });
        it(@"Add object at index", ^{

          NSInteger indexToAdd = 0;

          OCMStub([providerSection addItemToSection:c atIndex:indexToAdd]).andReturn(YES);

          BOOL wasAdded = [provider addObject:c atIndexPath:[NSIndexPath indexPathForRow:indexToAdd inSection:sectionIndex]];

          expect(wasAdded).to.beTruthy();
          OCMVerify([providerSection addItemToSection:c atIndex:indexToAdd]);

        });

        it(@"remove objects", ^{
          [provider addObjectsToProviderData:data inSection:sectionIndex];
          OCMStub([providerSection removeItemsFromSection:data]).andReturn(@[ @(1)]);
            
            
            
          NSArray *removedIndexes = [provider removeObjectsFromProvider:data inSection:sectionIndex];
          expect(removedIndexes).toNot.beNil();

          

        });
//        it(@"Remove single object", ^{
//          NSInteger removedIndex = [provider removeObjectFromProvider:c inSection:section];
//          if (removedIndex != -1) {
//              expect(currentSection.sectionItems).toNot.contain(c);
//          } else {
//              expect(currentSection.sectionItems).to.contain(c);
//          }
//        });
#warning TODO: ADD Test for ADD/Remove Sections
      });
    });
SpecEnd
