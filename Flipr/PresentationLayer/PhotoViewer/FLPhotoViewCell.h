//
//  FLPhotoViewCell.h
//  Flipr
//
//  Created by Adem Atalay on 22.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
@class FLPhotoModel;
@protocol FLDataGathering;

@interface FLPhotoViewCell : UICollectionViewCell

- (void)configureWithViewModel:(FLPhotoModel *)viewModel mediaService:(id<FLDataGathering>)mediaService;

@end

NS_ASSUME_NONNULL_END
