//
//  FLDataModel+Private.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLDataModel (Private)

+ (Class)classForObjectsInArrayWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
