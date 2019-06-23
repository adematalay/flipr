//
//  FLPhotoListViewControllerTests.m
//  FliprTests
//
//  Created by Adem Atalay on 23.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLDataGathering.h"
#import "FLPhotoListDataSource.h"
#import "FLPhotoListViewController.h"

@interface FLMockDataSource : FLPhotoListDataSource

@property (nonatomic) void(^searchBlock)(NSString *keyword);

@end

@interface FLPhotoListViewControllerTests : XCTestCase <FLDataGathering>

@property (nonatomic) FLPhotoListViewController<UISearchBarDelegate> *viewController;
@property (nonatomic) FLMockDataSource *dataSource;

@end

@implementation FLPhotoListViewControllerTests

- (void)setUp {
    [super setUp];
    self.dataSource = [[FLMockDataSource alloc] initWithDataService:self mediaService:self];
    self.dataSource.searchBlock = ^(NSString *keyword) {};
    FLPhotoListViewController *viewController = [[FLPhotoListViewController alloc] initWithDataSource:self.dataSource];
    self.viewController = (FLPhotoListViewController<UISearchBarDelegate> *)viewController;
}

- (void)testSearchBarDidSearchWithSameKeyword {
    UISearchBar *searchBar = UISearchBar.new;
    searchBar.text = @"test";
    self.dataSource.searchBlock = nil; // Should crash if this test fails
    [self.dataSource setValue:@"test" forKey:@"searchKeyword"];
    [self.viewController searchBarSearchButtonClicked:searchBar];
}

- (void)testSearchBarDidSearch {
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    UISearchBar *searchBar = UISearchBar.new;
    searchBar.text = @"test";
    __block NSString *key;
    self.dataSource.searchBlock = ^(NSString *keyword) {
        key = keyword;
        [exp fulfill];
    };
    [self.viewController searchBarSearchButtonClicked:searchBar];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        XCTAssert([key isEqualToString:@"test"]);
    }];
}

- (void)testSearchBarCancel {
    UISearchBar *searchBar = UISearchBar.new;
    searchBar.text = @"test_tmp";
    [self.dataSource setValue:@"test" forKey:@"searchKeyword"];
    
    [self.viewController searchBarCancelButtonClicked:searchBar];
    
    XCTAssert([searchBar.text isEqualToString:@"test"]);
}

- (void)testSearchBarDidBeginEditing {
    UISearchBar *searchBar = UISearchBar.new;
    searchBar.showsCancelButton = NO;
    
    [self.viewController searchBarTextDidBeginEditing:searchBar];
    
    XCTAssert(searchBar.showsCancelButton == YES);
}

- (void)testSearchBarDidEndEditing {
    UISearchBar *searchBar = UISearchBar.new;
    searchBar.showsCancelButton = YES;
    
    [self.viewController searchBarTextDidEndEditing:searchBar];
    
    XCTAssert(searchBar.showsCancelButton == NO);
}

@end

@implementation FLMockDataSource

- (void)searchPhotosWithKeyword:(NSString *)keyword {
    self.searchBlock(keyword);
}

@end
