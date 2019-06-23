//
//  FLPhotoListDataSource.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@protocol FLDataGathering;

@interface FLPhotoListDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, readonly) NSString *searchKeyword;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDataService:(id<FLDataGathering>)dataService
                       mediaService:(id<FLDataGathering>)mediaService NS_DESIGNATED_INITIALIZER;

- (void)searchPhotosWithKeyword:(NSString *)keyword;

@end

NS_ASSUME_NONNULL_END
