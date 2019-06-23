//
//  FLTask+Private.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLTask (Private)

- (instancetype)initWithDataTask:(NSURLSessionDataTask *)dataTask;

@end

NS_ASSUME_NONNULL_END
