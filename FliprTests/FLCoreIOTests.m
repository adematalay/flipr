//
//  FLCoreIOTests.m
//  FliprTests
//
//  Created by Adem Atalay on 22.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLResultsModel.h"
#import "FLCoreIO.h"

@interface FLCoreIOTests : XCTestCase

@end

@implementation FLCoreIOTests

- (void)testWriteDataTests {
    FLCoreIO *io = FLCoreIO.new;
    NSString *testKey = @"testKey";
    NSDictionary *dict = @{@"id":@"testID", @"secret":@"testSecret"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    
    //Store
    [io storeObject:data forKey:testKey];
    id stored = [io dataObjectForKey:testKey];
    XCTAssertNotNil(stored);
    XCTAssert([stored isKindOfClass:NSData.class]);
    XCTAssert([stored isEqualToData:data]);
    
    //delete file
    [io storeObject:nil forKey:testKey];
    XCTAssertNil([io dataObjectForKey:testKey]);
}

- (void)testWriteDictionaryTests {
    FLCoreIO *io = FLCoreIO.new;
    NSString *testKey = @"testKey";
    NSDictionary *dict = @{@"id":@"testID", @"secret":@"testSecret"};
    
    //Store
    [io storeObject:dict forKey:testKey];
    id stored = [io dictionaryObjectForKey:testKey];
    XCTAssertNotNil(stored);
    XCTAssert([stored isKindOfClass:NSDictionary.class]);
    XCTAssert([stored isEqualToDictionary:dict]);
    
    //delete file
    [io storeObject:nil forKey:testKey];
    XCTAssertNil([io dataObjectForKey:testKey]);
}


@end
