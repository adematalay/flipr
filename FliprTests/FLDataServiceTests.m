//
//  FLDataServiceTests.m
//  FliprTests
//
//  Created by Adem Atalay on 23.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLDataService.h"
#import "FLNetworking.h"
#import "FLPersisting.h"

@interface FLDataServiceTests : XCTestCase <FLNetworking, FLPersisting>

@property (nonatomic) FLDataService *dataService;
@property (nonatomic) NSDictionary *cacheDictionary;
@property (nonatomic) NSDictionary *networkDictionary;
@property (nonatomic) dispatch_block_t storeBlock;

@end

@implementation FLDataServiceTests

- (void)setUp {
    self.cacheDictionary = @{@"photos": @{@"page":@1, @"pages":@33,
                                     @"photo":@[ @{@"id":@"test_id1", @"title":@"test_title1"},
                                                 @{@"id":@"test_id2", @"title":@"test_title2"}
                                                 ]}};
    
    self.networkDictionary = self.cacheDictionary.copy;
    self.dataService = [[FLDataService alloc] initWithNetworking:self persisting:self];
}

- (void)testWithoutCachedDataWithKeyword {
    XCTestExpectation *exp = [self expectationWithDescription:@"testWithoutCachedDataWithKeyword"];
    self.cacheDictionary = nil;
    
    self.storeBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [exp fulfill];
        });
    };
    
    __block int numberOfCalls = 0;
    [self.dataService dataWithKeyword:@"testkw" completion:^(id object, NSError *error) {
        numberOfCalls ++;
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssert(numberOfCalls == 1);
    }];
}

- (void)testWithCachedDataWithKeyword {
    XCTestExpectation *exp = [self expectationWithDescription:@"testWithoutCachedDataWithKeyword"];
    
    self.storeBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [exp fulfill];
        });
    };
    
    __block int numberOfCalls = 0;
    [self.dataService dataWithKeyword:@"testkw" completion:^(id object, NSError *error) {
        numberOfCalls ++;
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssert(numberOfCalls == 2);
    }];
}

- (void)testWithoutValidCachedDataWithKeyword {
    XCTestExpectation *exp = [self expectationWithDescription:@"testWithoutCachedDataWithKeyword"];
    self.networkDictionary = nil;
    self.storeBlock = nil; //Should not be callse
    
    __block int numberOfCalls = 0;
    [self.dataService dataWithKeyword:@"testkw" completion:^(id object, NSError *error) {
        numberOfCalls ++;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssert(numberOfCalls == 1);
    }];
}

- (void)testWithoutInvalidCachedDataWithKeyword {
    XCTestExpectation *exp = [self expectationWithDescription:@"testWithoutCachedDataWithKeyword"];
    self.cacheDictionary = nil;
    self.networkDictionary = nil;
    self.storeBlock = nil; //Should not be callse
    
    __block int numberOfCalls = 0;
    [self.dataService dataWithKeyword:@"testkw" completion:^(id object, NSError *error) {
        numberOfCalls ++;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssert(numberOfCalls == 0);
    }];
}

// MARK: FLNetworking
- (id<FLCancellable>)dataWithRequest:(FLURLRequest *)urlRequest completion:(void (^)(id object, NSError * error))completion {
    completion(self.networkDictionary, nil);
    return nil;
}

// MARK: FLPersisting
- (NSData *)dataObjectForKey:(NSString *)key {
    return nil;
}

- (NSDictionary *)dictionaryObjectForKey:(NSString *)key {
    return self.cacheDictionary;
}

- (void)storeObject:(id)object forKey:(NSString *)key {
    self.storeBlock();
}

@end
