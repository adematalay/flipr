//
//  FLResultsModel.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLDataModel.h"

@interface FLPhotoModel : FLDataModel

@property (nonatomic, readonly) NSString *id;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *farm;
@property (nonatomic, readonly) NSString *server;
@property (nonatomic, readonly) NSString *secret;

@end

@interface FLPhotosModel : FLDataModel

@property (nonatomic, readonly) NSInteger page;
@property (nonatomic, readonly) NSInteger pages;
@property (nonatomic, readonly) NSArray<FLPhotoModel *> *photo;

@end

@interface FLResultsModel : FLDataModel

@property (nonatomic, readonly) FLPhotosModel *photos;

@end
