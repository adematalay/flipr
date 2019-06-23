//
//  FLCancellable.h
//  Flipr
//
//  Created by Adem Atalay on 20.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol FLCancellable <NSObject>

/**
 * @brief cancels the execution of the object
 */
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
