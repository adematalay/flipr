//
//  FLURLRequestTests.m
//  FliprTests
//
//  Created by Adem Atalay on 23.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLResultsModel.h"
#import "FLFlickrRequest.h"
#import "FLFlickrImageRequest.h"

@interface FLURLRequestTests : XCTestCase

@end

@implementation FLURLRequestTests

- (void)testRequestWithKeyword {
    NSString *urlString = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=test&page=10";
    FLFlickrRequest *r = [[FLFlickrRequest alloc] initWithKeyword:@"test" page:10];
    XCTAssert([urlString isEqualToString:r.request.URL.absoluteString]);
    XCTAssert([r.request.HTTPMethod isEqualToString:@"GET"]);
}

- (void)testPhotoRequestWithKeyword {
    NSString *urlString = @"https://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg";
    NSDictionary *dict = @{@"farm":@1, @"server":@(578), @"id":@"23451156376", @"secret":@"8983a8ebc7" };
    FLPhotoModel *model = [[FLPhotoModel alloc] initWithDictionary:dict];
    FLFlickrImageRequest *r = [[FLFlickrImageRequest alloc] initWithPhoto:model];
    XCTAssert([urlString isEqualToString:r.request.URL.absoluteString]);
    XCTAssert([r.request.HTTPMethod isEqualToString:@"GET"]);
}

@end
