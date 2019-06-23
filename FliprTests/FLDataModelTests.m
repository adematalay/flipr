//
//  FLDataModelTests.m
//  FliprTests
//
//  Created by Adem Atalay on 22.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLResultsModel.h"

@interface FLDataModelTests : XCTestCase

@end

@implementation FLDataModelTests

- (void)testComplexParsing {
    
    NSDictionary *d = @{@"photos": @{@"page":@1, @"pages":@33,
                                     @"photo":@[ @{@"id":@"test_id1", @"title":@"test_title1"},
                                                 @{@"id":@"test_id2", @"title":@"test_title2"}
                                                 ]}};
    
    FLResultsModel *model = [[FLResultsModel alloc] initWithDictionary:d];
    XCTAssertNotNil(model);
    XCTAssertNotNil(model.photos);
    XCTAssert(model.photos.photo.count == 2);
    XCTAssert([model.photos.photo.firstObject.id isEqualToString:@"test_id1"]);
}

- (void)testDescription {
    NSDictionary *d = @{@"photos": @{@"page":@1, @"pages":@33,
                                     @"photo":@[ @{@"id":@"test_id1", @"title":@"test_title1"},
                                                 @{@"id":@"test_id2", @"title":@"test_title2"}
                                                 ]}};
    
    FLResultsModel *model = [[FLResultsModel alloc] initWithDictionary:d];
    XCTAssertNotNil(model.description);
    XCTAssert([model.description hasSuffix:d.description]);
}

- (void)testCopying {
    NSDictionary *d = @{@"photos": @{@"page":@1, @"pages":@33,
                                     @"photo":@[ @{@"id":@"test_id1", @"title":@"test_title1"},
                                                 @{@"id":@"test_id2", @"title":@"test_title2"}
                                                 ]}};
    
    FLResultsModel *model = [[FLResultsModel alloc] initWithDictionary:d];
    FLResultsModel *copy = model.copy;
    XCTAssertEqual(model.dictionaryRepresentation, copy.dictionaryRepresentation);
}


@end
