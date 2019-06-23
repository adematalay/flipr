//
//  FLCoreNetwork.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLNetworking.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^URLResponseBlock)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable);

@interface FLCoreNetwork : NSObject <FLNetworking>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithSession:(NSURLSession *)sesssion NS_DESIGNATED_INITIALIZER;

- (URLResponseBlock)handlerWithComletionBlock:(void (^)(id object, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
