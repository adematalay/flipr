//
//  FLAbstractService.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLDataGathering.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FLNetworking;
@protocol FLPersisting;
@interface FLAbstractService : NSObject <FLDataGathering>

@property (nonatomic, readonly) id<FLNetworking> networking;
@property (nonatomic, readonly) id<FLPersisting> persisting;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithNetworking:(id<FLNetworking>)networking
                        persisting:(id<FLPersisting>)persisting NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
