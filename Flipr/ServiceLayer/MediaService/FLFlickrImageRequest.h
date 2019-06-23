//
//  FLFlickrImageRequest.h
//  Flipr
//
//  Created by Adem Atalay on 22.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLURLRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class FLPhotoModel;
@interface FLFlickrImageRequest : FLURLRequest

- (instancetype)initWithPhoto:(FLPhotoModel *)photo;

@end

NS_ASSUME_NONNULL_END
