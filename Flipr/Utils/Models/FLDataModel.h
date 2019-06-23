//
//  FLDataModel.h
//  Flipr
//
//  Created by Adem Atalay on 20.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 * @brief deserializes a dictionary into a model object. Objects of a model object must be same kind of model object
 *        so only dictinary and array types are supported
 *
 *        Data models should be immutable, so all of its properties must be readonly however there is no check for these
 *        in this implementation
 */
@interface FLDataModel : NSObject <NSCopying>

@property (nonatomic, readonly, copy) NSDictionary *dictionaryRepresentation;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
