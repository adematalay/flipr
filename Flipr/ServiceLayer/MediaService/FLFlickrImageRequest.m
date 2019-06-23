//
//  FLFlickrImageRequest.m
//  Flipr
//
//  Created by Adem Atalay on 22.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLFlickrImageRequest.h"
#import "FLResultsModel.h"

@implementation FLFlickrImageRequest
@synthesize request = _request;

- (instancetype)initWithPhoto:(FLPhotoModel *)photo {
    self = [super init];
    if (self) {
        NSString *urlString = [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@.jpg", photo.farm, photo.server, photo.id, photo.secret];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        
        _request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    }
    return self;
}

@end
