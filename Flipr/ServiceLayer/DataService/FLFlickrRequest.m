//
//  FLFlickrRequest.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLFlickrRequest.h"

@implementation FLFlickrRequest
@synthesize request = _request;

- (instancetype)initWithKeyword:(NSString *)keyword page:(NSInteger)page {
    self = [super init];
    if (self) {
        _request = [NSURLRequest requestWithURL:[[self componentsWithKeyword:keyword page:@(page).stringValue] URL]];
    }
    return self;
}

- (NSURLComponents *)componentsWithKeyword:(NSString *)keyword page:(NSString *)page {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    NSMutableArray<NSURLQueryItem *> *queryItems = NSMutableArray.new;
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"method" value:@"flickr.photos.search"]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"api_key" value:@"3e7cc266ae2b0e0d78e279ce8e361736"]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"format" value:@"json"]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"nojsoncallback" value:@"1"]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"safe_search" value:@"1"]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"text" value:keyword]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"page" value:page]];
    components.queryItems = queryItems.copy;
    
    return components;
}

@end
