//
//  FLPhotoListViewController.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLPhotoListViewController.h"
#import "FLPhotoListFlowLayout.h"
#import "FLPhotoListDataSource.h"
#import "FLPhotoViewCell.h"

@interface FLPhotoListViewController () <UISearchBarDelegate>

@property (nonatomic) FLPhotoListDataSource *dataSource;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UISearchBar *searchBar;

@end

@implementation FLPhotoListViewController

- (instancetype)initWithDataSource:(FLPhotoListDataSource *)dataSource {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:36/255.0 green:123/255.0 blue:160/255.0 alpha:1];
        
        _dataSource = dataSource;
        _dataSource.collectionView = self.collectionView;
        [self.view addSubview:self.searchBar];
        [self.view addSubview:self.collectionView];
        [self setupContraints];
        
        //start with a default search
        [dataSource searchPhotosWithKeyword:@"kittens"];
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        FLPhotoListFlowLayout *flowLayout = FLPhotoListFlowLayout.new;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.dataSource = self.dataSource;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
        
        [_collectionView registerClass:FLPhotoViewCell.class forCellWithReuseIdentifier:NSStringFromClass(FLPhotoViewCell.class)];
    }
    return _collectionView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = UISearchBar.new;
        _searchBar.tintColor = UIColor.whiteColor;
        _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
        _searchBar.delegate = self;
        _searchBar.placeholder = @"Search for photos";
        [_searchBar setBackgroundImage:UIImage.new forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        _searchBar.backgroundColor = self.view.backgroundColor;
        _searchBar.barTintColor = self.view.backgroundColor;
    }
    return _searchBar;
}

- (void)setupContraints {
    [NSLayoutConstraint activateConstraints:@[
          [self.view.leadingAnchor constraintEqualToAnchor:self.searchBar.leadingAnchor],
          [self.view.trailingAnchor constraintEqualToAnchor:self.searchBar.trailingAnchor],
          [self.searchBar.bottomAnchor constraintEqualToAnchor:self.collectionView.topAnchor],
          [self.view.bottomAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor],
          [self.view.leadingAnchor constraintEqualToAnchor:self.collectionView.leadingAnchor],
          [self.view.trailingAnchor constraintEqualToAnchor:self.collectionView.trailingAnchor],
    ]];
    
    if (@available(iOS 11, *)) {
        [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.searchBar.topAnchor].active = YES;
    } else {
        CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
        [self.searchBar.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:barHeight].active = YES;
    }
}

// MARK: - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if ([searchBar.text isEqualToString:self.dataSource.searchKeyword]) {
        return;
    }
    
    [self.dataSource searchPhotosWithKeyword:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = self.dataSource.searchKeyword;
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
}

@end
