//
//  FLCoordinator.m
//  Flipr
//
//  Created by Adem Atalay on 20.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLCoordinator.h"
#import "FLPhotoListViewController.h"
#import "FLPhotoListDataSource.h"
#import "FLMediaService.h"
#import "FLDataService.h"
#import "FLCoreNetwork.h"
#import "FLCoreIO.h"

@interface FLCoordinator()

@property (nonatomic) id<FLDataGathering> mediaService;
@property (nonatomic) id<FLDataGathering> dataService;

@end

@implementation FLCoordinator
@synthesize startupViewController = _startupViewController;

- (instancetype)init {
    self = [super init];
    if (self) {
        FLCoreNetwork *networking = [[FLCoreNetwork alloc] initWithSession:NSURLSession.sharedSession];
        FLCoreIO *persisting = FLCoreIO.new;
        _dataService = [[FLDataService alloc] initWithNetworking:networking persisting:persisting];
        _mediaService = [[FLMediaService alloc] initWithNetworking:networking persisting:persisting];
    }
    return self;
}

- (UIViewController *)startupViewController {
    if (!_startupViewController) {
        FLPhotoListDataSource *dataSource = [[FLPhotoListDataSource alloc] initWithDataService:self.dataService
                                                                                  mediaService:self.mediaService];
        _startupViewController = [[FLPhotoListViewController alloc] initWithDataSource:dataSource];
    }
    return _startupViewController;
}

@end
