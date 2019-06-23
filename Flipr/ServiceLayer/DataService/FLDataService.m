//
//  FLDataService.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLDataService.h"
#import "FLPersisting.h"
#import "FLNetworking.h"
#import "FLResultsModel.h"
#import "FLFlickrRequest.h"

@implementation FLDataService

- (id<FLCancellable>)dataWithKeyword:(NSString *)keyword completion:(void (^)(id, NSError *))completion {
    //get it from cache
    FLResultsModel *cachedObject = [[FLResultsModel alloc] initWithDictionary:[self.persisting dictionaryObjectForKey:keyword]];
    if (cachedObject) {
        completion(cachedObject, nil);
    }
    
    //get it from network
    return [self dataWithKeyword:keyword page:1 completion:completion];
}

- (id<FLCancellable>)dataWithKeyword:(NSString *)keyword page:(NSInteger)page completion:(void (^)(id, NSError *))completion {
    FLFlickrRequest *request = [[FLFlickrRequest alloc] initWithKeyword:keyword page:page];
    __weak FLDataService *weakSelf = self;
    return [self.networking dataWithRequest:request completion:^(NSDictionary *object, NSError *error) {
        FLResultsModel *results = [[FLResultsModel alloc] initWithDictionary:object];
        if (!results) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(results, nil);
        });
        
        // Store only first page
        __strong FLDataService *strongSelf = weakSelf;
        if (page == 1) {
            [strongSelf.persisting storeObject:object forKey:keyword];
        }
    }];
}

@end
