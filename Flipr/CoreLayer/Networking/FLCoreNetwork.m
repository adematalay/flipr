//
//  FLCoreNetwork.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLCoreNetwork.h"
#import "FLTask+Private.h"
#import "FLURLRequest.h"

static NSString *const FLDefaultErrorDoimain = @"FLDefaultErrorDoimain";

@interface FLCoreNetwork()

@property (nonatomic) NSURLSession *session;

@end

@implementation FLCoreNetwork

- (instancetype)initWithSession:(NSURLSession *)sesssion {
    self = [super init];
    if (self) {
        _session = sesssion;
    }
    return self;
}

- (id<FLCancellable>)dataWithRequest:(FLURLRequest *)urlRequest completion:(void (^)(id, NSError *))completion {
    id handler = [self handlerWithComletionBlock:completion];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:urlRequest.request completionHandler:handler];
    [dataTask resume];
    return [[FLTask alloc] initWithDataTask:dataTask];
}

- (URLResponseBlock)handlerWithComletionBlock:(void (^)(id object, NSError *error))completion {
    return ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if ([response.MIMEType isEqualToString:@"application/json"]) {
            NSError *err;
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                completion(nil, err);
                return;
            }
            
            completion(obj, nil);
            return;
        }
        
        if (data) {
            completion(data, nil);
            return;
        }
        
        completion(nil, [NSError errorWithDomain:FLDefaultErrorDoimain code:-1 userInfo:nil]);
    };
}

@end
