//
//  FLCoreNetworkTests.m
//  FliprTests
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLFlickrRequest.h"
#import "FLCoreNetwork.h"

@interface FLCoreNetworkTests : XCTestCase

@property (nonatomic) FLCoreNetwork *networking;

@end

@implementation FLCoreNetworkTests

- (void)setUp {
    [super setUp];
    self.networking = [[FLCoreNetwork alloc] initWithSession:NSURLSession.sharedSession];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCompletionHandlerWithError {
    URLResponseBlock block = [self.networking handlerWithComletionBlock:^(id  _Nonnull object, NSError * _Nonnull error) {
        XCTAssertNil(object);
        XCTAssertNotNil(error);
        XCTAssert(error.code == -100);
    }];
    
    block(nil, nil, [NSError errorWithDomain:@"TestDomain" code:-100 userInfo:nil]);
}

- (void)testCompletionHandlerWithNoErrorNoData {
    URLResponseBlock block = [self.networking handlerWithComletionBlock:^(id  _Nonnull object, NSError * _Nonnull error) {
        XCTAssertNil(object);
        XCTAssertNotNil(error);
        XCTAssert(error.code == -1);
    }];
    
    block(nil, nil, nil);
}

- (void)testCompletionHandlerWithData {
    NSData *data = [@"testData" dataUsingEncoding:NSUTF8StringEncoding];
    
    URLResponseBlock block = [self.networking handlerWithComletionBlock:^(id  _Nonnull object, NSError * _Nonnull error) {
        XCTAssertNotNil(object);
        XCTAssertNil(error);
        XCTAssert([object isKindOfClass:NSData.class]);
        XCTAssert([object isEqualToData:data]);
    }];
    
    block(data, nil, nil);
}

- (void)testCompletionHandlerWithDictionary {
    NSDictionary *dict = @{@"id":@"testID", @"secret":@"testSecret"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    XCTAssertNotNil(data);
    
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[NSURL URLWithString:@"https://testdomain.com"]
                                                        MIMEType:@"application/json"
                                           expectedContentLength:200
                                                textEncodingName:nil];
    
    URLResponseBlock block = [self.networking handlerWithComletionBlock:^(id  _Nonnull object, NSError * _Nonnull error) {
        XCTAssertNotNil(object);
        XCTAssertNil(error);
        XCTAssert([object isKindOfClass:NSDictionary.class]);
        XCTAssert([object isEqualToDictionary:dict]);
    }];
    
    block(data, response, nil);
}

- (void)testCompletionHandlerWithNonDictionary {
    NSData *data = [@"testData" dataUsingEncoding:NSUTF8StringEncoding];
    XCTAssertNotNil(data);
    
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[NSURL URLWithString:@"https://testdomain.com"]
                                                        MIMEType:@"application/json"
                                           expectedContentLength:200
                                                textEncodingName:nil];
    
    URLResponseBlock block = [self.networking handlerWithComletionBlock:^(id  _Nonnull object, NSError * _Nonnull error) {
        XCTAssertNil(object);
        XCTAssertNotNil(error);
    }];
    
    block(data, response, nil);
}

/*
- (void)testRealRequest {
    XCTestExpectation *exp = [self expectationWithDescription:@"req"];
    
    FLFlickrRequest *r = [[FLFlickrRequest alloc] initWithKeyword:@"kittens" page:1];
    FLCoreNetwork *networking = [[FLCoreNetwork alloc] initWithSession:NSURLSession.sharedSession];
    [networking dataWithRequest:r completion:^(id object, NSError *error) {
        if ([object isKindOfClass:NSDictionary.class]) {
            [exp fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {}];
}*/

@end
