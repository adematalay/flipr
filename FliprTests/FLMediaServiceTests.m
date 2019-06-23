//
//  FLMediaServiceTests.m
//  FliprTests
//
//  Created by Adem Atalay on 23.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLMediaService.h"
#import "FLNetworking.h"
#import "FLPersisting.h"
#import "FLResultsModel.h"

@interface FLMediaServiceTests : XCTestCase <FLNetworking, FLPersisting>

@property (nonatomic) FLMediaService *mediaService;
@property (nonatomic) FLPhotoModel *photoModel;
@property (nonatomic) NSData *imageData;
@property (nonatomic) NSData *cachedData;
@property (nonatomic) dispatch_block_t storeBlock;

@end

@implementation FLMediaServiceTests

- (void)setUp {
    NSDictionary *dict = @{@"farm":@1, @"server":@(578), @"id":@"23451156376", @"secret":@"8983a8ebc7" };
    self.photoModel = [[FLPhotoModel alloc] initWithDictionary:dict];
    self.mediaService = [[FLMediaService alloc] initWithNetworking:self persisting:self];
    UIImage *image = [self generateBlueCircle];
    self.imageData = UIImageJPEGRepresentation(image, 1.0);
    self.cachedData = UIImageJPEGRepresentation(image, 1.0);
}


- (void)testWithoutCachedDataWithoutResult {
    XCTestExpectation *exp = [self expectationWithDescription:@"testWithoutCachedDataWithoutResult"];
    self.cachedData = nil;
    self.imageData = nil;
    self.storeBlock = nil;
    
    __block int numberOfCalls = 0;
    [self.mediaService dataWithModel:self.photoModel completion:^(id object, NSError *error) {
        numberOfCalls ++;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssert(numberOfCalls == 0);
    }];
}

- (void)testWithCachedDataWithoutResult {
    XCTestExpectation *exp = [self expectationWithDescription:@"testWithCachedDataWithoutResult"];
    self.imageData = nil;
    self.storeBlock = nil;
    
    __block int numberOfCalls = 0;
    [self.mediaService dataWithModel:self.photoModel completion:^(id object, NSError *error) {
        numberOfCalls ++;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssert(numberOfCalls == 1);
    }];
}

- (void)testWithCachedDataWithResult {
    XCTestExpectation *exp = [self expectationWithDescription:@"testWithCachedDataWithResult"];
    self.storeBlock = nil;
    
    __block int numberOfCalls = 0;
    [self.mediaService dataWithModel:self.photoModel completion:^(id object, NSError *error) {
        numberOfCalls ++;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssert(numberOfCalls == 1);
    }];
}

- (void)testWithoutCachedDataWithResult {
    XCTestExpectation *exp = [self expectationWithDescription:@"testWithCachedDataWithResult"];
    self.cachedData = nil;
    self.storeBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [exp fulfill];
        });
    };
    
    __block int numberOfCalls = 0;
    [self.mediaService dataWithModel:self.photoModel completion:^(id object, NSError *error) {
        numberOfCalls ++;
    }];

    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssert(numberOfCalls == 1);
    }];
}

// MARK: FLNetworking
- (id<FLCancellable>)dataWithRequest:(FLURLRequest *)urlRequest completion:(void (^)(id object, NSError * error))completion {
    completion(self.imageData, nil);
    return nil;
}

// MARK: FLPersisting
- (NSData *)dataObjectForKey:(NSString *)key {
    return self.cachedData;
}

- (NSDictionary *)dictionaryObjectForKey:(NSString *)key {
    return nil;
}

- (void)storeObject:(id)object forKey:(NSString *)key {
    self.storeBlock();
}

// MARK: - Helper
- (UIImage *)generateBlueCircle {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50.f, 50.f), YES, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
        
    CGRect rect = CGRectMake(0, 0, 50, 50);
    CGContextSetFillColorWithColor(ctx, [UIColor cyanColor].CGColor);
    CGContextFillEllipseInRect(ctx, rect);
        
    CGContextRestoreGState(ctx);
    UIImage *blueCircle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return blueCircle;
}

@end
