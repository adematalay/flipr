//
//  FLMediaService.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLMediaService.h"
#import "FLPersisting.h"
#import "FLNetworking.h"
#import "FLResultsModel.h"
#import "FLFlickrImageRequest.h"
@import UIKit;

@implementation FLMediaService

- (id<FLCancellable>)dataWithModel:(FLPhotoModel *)photo completion:(void (^)(id object, NSError *error))completion {
    // If image is cached already, return the cached data from persistence
    NSString *mediaFileName = [self mediaFileName:photo];
    UIImage *cachedImage =  [UIImage imageWithData:[self.persisting dataObjectForKey:mediaFileName]];
    if (cachedImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(cachedImage, nil);
        });
        return nil;
    }
    
    // Download the imag eand store in persistence
    FLFlickrImageRequest *request = [[FLFlickrImageRequest alloc] initWithPhoto:photo];
    __weak FLMediaService *weakSelf = self;
    return [self.networking dataWithRequest:request completion:^(NSData *object, NSError *error) {
        UIImage *image = [UIImage imageWithData:object];
        if (!image) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image, nil);
        });
        
        __strong FLMediaService *strongSelf = weakSelf;
        [strongSelf.persisting storeObject:object forKey:mediaFileName];
    }];
}

- (NSString *)mediaFileName:(FLPhotoModel *)photo {
    return [NSString stringWithFormat:@"%@_%@.jpg", photo.id, photo.secret];
}

@end
