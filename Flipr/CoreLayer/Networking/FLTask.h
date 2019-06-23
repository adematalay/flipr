//
//  FLTask.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLCancellable.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLTask : NSObject <FLCancellable>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
