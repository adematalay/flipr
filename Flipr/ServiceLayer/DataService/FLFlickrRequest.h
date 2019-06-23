//
//  FLFlickrRequest.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLURLRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLFlickrRequest : FLURLRequest

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithKeyword:(NSString *)keyword page:(NSInteger)page NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
