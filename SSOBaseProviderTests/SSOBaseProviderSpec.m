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
            
          wasAdded = [provider addObject:c atIndexPath:[NSIndexPath indexPathForRow:indexToAdd inSection:-1]];
            
            expect(wasAdded).to.beFalsy();

        });

        it(@"remove objects", ^{
          [provider addObjectsToProviderData:data inSection:sectionIndex];
            NSArray *mockReturn = @[@0,@1];
          OCMStub([providerSection removeItemsFromSection:data]).andReturn(mockReturn);
            
            
            
          NSArray *removedIndexes = [provider removeObjectsFromProvider:data inSection:sectionIndex];
          expect(removedIndexes).toNot.beNil();
          OCMVerify([providerSection removeItemsFromSection:data]);

          removedIndexes = [provider removeObjectsFromProvider:data inSection:-1];
          expect(removedIndexes).to.beNil();
            
            
        });
        it(@"Remove single object", ^{
            OCMStub([providerSection removeItemsFromSection:@[c]]).andReturn(@[@0]);
            NSInteger removedIndex = [provider removeObjectFromProvider:c inSection:sectionIndex];
            expect(removedIndex != NSNotFound).to.beTruthy();
            OCMVerify([providerSection removeItemsFromSection:@[c]]);
            
            
            removedIndex = [provider removeObjectFromProvider:c inSection:-1];
            expect(removedIndex == NSNotFound).to.beTruthy();
          
            
        });
#warning TODO: ADD Test for ADD/Remove Sections
      });
    });
SpecEnd
