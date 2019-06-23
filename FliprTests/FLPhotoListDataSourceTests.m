//
//  FLPhotoListDataSourceTests.m
//  FliprTests
//
//  Created by Adem Atalay on 23.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLPhotoListDataSource.h"
#import "FLDataGathering.h"
#import "FLCancellable.h"
#import "FLResultsModel.h"
#import "FLPhotoViewCell.h"

@interface FLPhotoListDataSource(Private)

@property (nonatomic) NSMutableArray<FLPhotoModel *> *photos;
@property (nonatomic) id<FLCancellable> currentTask;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger pages;

@end

@interface FLMockCollectionView : UICollectionView

@property (nonatomic) dispatch_block_t reloadDataBlock;
@property (nonatomic) void(^insertItemsAtIndexPathsBlock)(NSArray *);

@end

@interface FLPhotoListDataSourceTests : XCTestCase <FLDataGathering, FLCancellable>

@property (nonatomic) FLPhotoListDataSource *dataSource;
@property (nonatomic) FLMockCollectionView *collectionView;
@property (nonatomic) dispatch_block_t cancelBlock;

@end

@implementation FLPhotoListDataSourceTests

- (void)setUp {
    [super setUp];
    self.collectionView = [[FLMockCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:UICollectionViewFlowLayout.new];
    [self.collectionView registerClass:FLPhotoViewCell.class forCellWithReuseIdentifier:NSStringFromClass(FLPhotoViewCell.class)];
    
    self.dataSource = [[FLPhotoListDataSource alloc] initWithDataService:self mediaService:self];
    self.dataSource.collectionView = self.collectionView;
}

- (void)testSearchingWithKeyword {
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    self.collectionView.reloadDataBlock = ^{
        [exp fulfill];
    };
    XCTAssertNil(self.dataSource.searchKeyword);
    XCTAssertNil(self.dataSource.currentTask);
    [self.dataSource searchPhotosWithKeyword:@"test"];
    XCTAssert([self.dataSource.searchKeyword isEqualToString:@"test"]);
    XCTAssertEqual(self.dataSource.currentTask, self);
    XCTAssert(self.dataSource.page == 10);
    XCTAssert(self.dataSource.pages == 33);
    XCTAssert(self.dataSource.photos.count == 2);
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) { }];
}

- (void)testCollectionDelegateMethods {
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    self.collectionView.reloadDataBlock = ^{
        [exp fulfill];
    };
    [self.dataSource searchPhotosWithKeyword:@"test"];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        XCTAssert([self.dataSource numberOfSectionsInCollectionView:self.collectionView] == 1);
        XCTAssert(self.dataSource.photos.count == 2);
        XCTAssert([self.dataSource collectionView:self.collectionView numberOfItemsInSection:0] == self.dataSource.photos.count);
    }];
}

- (void)testLoadNextPage {
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    self.collectionView.reloadDataBlock = ^{};
    [self.dataSource searchPhotosWithKeyword:@"test"];
    
    XCTAssert(self.dataSource.page == 10);
    
    __block NSInteger cancelBlockCount = 0;
    self.cancelBlock = ^{
        cancelBlockCount ++;
    };
    
    self.collectionView.insertItemsAtIndexPathsBlock = ^(NSArray *indexPaths) {
        if (indexPaths.count == 2) {
            [exp fulfill];
        }
    };
    
    XCTAssertNotNil([self.dataSource collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]);
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        XCTAssert(self.dataSource.page == 11);
        XCTAssert(self.dataSource.pages == 33);
        XCTAssert(cancelBlockCount == 1);
        XCTAssert(self.dataSource.photos.count == 4);
    }];
}

- (void)testLoadNextPageOnLastPage {
    self.collectionView.reloadDataBlock = ^{};
    [self.dataSource searchPhotosWithKeyword:@"test"];
    self.dataSource.page = self.dataSource.pages;
    
    __block NSInteger cancelBlockCount = 0;
    self.cancelBlock = ^{
        cancelBlockCount ++;
    };
    
    XCTAssertNotNil([self.dataSource collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]);
    
    XCTAssert(cancelBlockCount == 1);
}


// MARK: - FLDataGathering
- (id<FLCancellable>)dataWithKeyword:(NSString *)keyword completion:(void (^)(id object, NSError *error))completion {
    NSDictionary *dict = @{@"photos": @{@"page":@10, @"pages":@33,
                                        @"photo":@[ @{@"id":@"test_id1", @"title":@"test_title1"},
                                                    @{@"id":@"test_id2", @"title":@"test_title2"}
                                                    ]}};
    FLResultsModel *results = [[FLResultsModel alloc] initWithDictionary:dict];
    completion(results, nil);
    return self;
}

- (id<FLCancellable>)dataWithKeyword:(NSString *)keyword page:(NSInteger)page completion:(void (^)(id, NSError *))completion {
    NSDictionary *dict = @{@"photos": @{@"page":@11, @"pages":@33,
                                        @"photo":@[ @{@"id":@"test_id1", @"title":@"test_title1"},
                                                    @{@"id":@"test_id2", @"title":@"test_title2"}
                                                    ]}};
    FLResultsModel *results = [[FLResultsModel alloc] initWithDictionary:dict];
    completion(results, nil);
    return self;
}

- (id<FLCancellable>)dataWithModel:(FLDataModel *)model completion:(void (^)(id object, NSError *error))completion {
    return nil;
}

// MARK: FLCancellable
- (void)cancel {
    self.cancelBlock();
}

@end


@implementation FLMockCollectionView

- (void)reloadData {
    self.reloadDataBlock();
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    self.insertItemsAtIndexPathsBlock(indexPaths);
}

@end
