//
//  FLDataGathering.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

@import Foundation;

@class FLDataModel;
@protocol FLCancellable;

@protocol FLDataGathering <NSObject>

@optional

/**
 * @brief Gatherd data with provided keyword and page, data can be different type according to implementation
 *
 * @param keyword NSString for request parameter, will not be sent if nil is passed
 * @param completion block for gathering response as a dictionary
 */
- (id<FLCancellable>)dataWithKeyword:(NSString *)keyword
                          completion:(void (^)(id object, NSError *error))completion;

/**
 * @brief Gatherd data with provided keyword and page, data can be different type according to implementation
 *
 * @param keyword NSString for request parameter, will not be sent if nil is passed
 * @param page NSInteger the page number for the request, each page will have default number of results
 * @param completion block for gathering response as a dictionary
 */
- (id<FLCancellable>)dataWithKeyword:(NSString *)keyword
                                page:(NSInteger)page
                          completion:(void (^)(id object, NSError *error))completion;

/**
 * @brief Gatherd image with provided data model, data can be different type according to implementation
 *
 * @param model FLDataModel for request parameter, will not be sent if nil is passed
 * @param completion block for gathering response as a dictionary
 */
- (id<FLCancellable>)dataWithModel:(FLDataModel *)model
                        completion:(void (^)(id object, NSError *error))completion;

@end
