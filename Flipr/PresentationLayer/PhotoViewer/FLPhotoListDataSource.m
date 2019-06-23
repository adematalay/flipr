//
//  FLPhotoListDataSource.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLPhotoListDataSource.h"
#import "FLPhotoViewCell.h"
#import "FLDataGathering.h"
#import "FLResultsModel.h"
#import "FLCancellable.h"

@interface FLPhotoListDataSource()

@property (nonatomic, readonly) id<FLDataGathering> dataService;
@property (nonatomic, readonly) id<FLDataGathering> mediaService;
@property (nonatomic) NSMutableArray<FLPhotoModel *> *photos;
@property (nonatomic) id<FLCancellable> currentTask;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger pages;

@end

@implementation FLPhotoListDataSource

- (instancetype)initWithDataService:(id<FLDataGathering>)dataService
                       mediaService:(id<FLDataGathering>)mediaService {
    self = [super init];
    if (self) {
        _dataService = dataService;
        _mediaService = mediaService;
    }
    return self;
}

- (void)searchPhotosWithKeyword:(NSString *)keyword {
    [self.currentTask cancel];
    
    _searchKeyword = keyword.copy;
    __weak FLPhotoListDataSource *weakSelf = self;
    self.currentTask = [self.dataService dataWithKeyword:keyword completion:^(FLResultsModel *object, NSError *error) {
        if (object) {
            __strong FLPhotoListDataSource *strongSelf = weakSelf;
            strongSelf.page = object.photos.page;
            strongSelf.pages = object.photos.pages;
            strongSelf.photos = object.photos.photo.mutableCopy ?: NSMutableArray.new;
            [strongSelf.collectionView reloadData];
        }
    }];
}

- (void)loadNextPage {
    [self.currentTask cancel];
    
    if (self.page >= self.pages) {
        return;
    }
    
    __weak FLPhotoListDataSource *weakSelf = self;
    self.currentTask = [self.dataService dataWithKeyword:self.searchKeyword page:self.page+1 completion:^(FLResultsModel *object, NSError *error) {
        if (object) {
            __strong FLPhotoListDataSource *strongSelf = weakSelf;
            strongSelf.page = object.photos.page;
            strongSelf.pages = object.photos.pages;
            NSMutableArray *indexPaths = NSMutableArray.new;
            for (NSUInteger i=strongSelf.photos.count;i<strongSelf.photos.count + object.photos.photo.count;i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            [strongSelf.photos addObjectsFromArray:object.photos.photo];
            [strongSelf.collectionView insertItemsAtIndexPaths:indexPaths];
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FLPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(FLPhotoViewCell.class)
                                                                           forIndexPath:indexPath];
    [cell configureWithViewModel:self.photos[indexPath.row] mediaService:self.mediaService];
    
    if (indexPath.row == self.photos.count - 1) {
        [self loadNextPage];
    }
    
    return cell;
}

@end
