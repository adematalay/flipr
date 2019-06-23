//
//  FLNetworking.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

@import Foundation;

@class FLURLRequest;
@protocol FLCancellable;

@protocol FLNetworking <NSObject>

/**
 * @brief Gatherd data with provided url request, data can be different type according to implementation
 *
 * @param urlRequest FLURLRequest request for data
 * @param completion block for gathering response
 */
- (id<FLCancellable>)dataWithRequest:(FLURLRequest *)urlRequest
                          completion:(void (^)(id object, NSError * error))completion;

@end
