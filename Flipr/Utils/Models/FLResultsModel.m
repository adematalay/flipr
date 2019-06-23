//
//  FLResultsModel.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLResultsModel.h"
#import "FLDataModel+Private.h"

@implementation FLPhotoModel
@end

@implementation FLPhotosModel

+ (Class)classForObjectsInArrayWithKey:(NSString *)key {
    if ([key isEqualToString:@"photo"]) {
        return FLPhotoModel.class;
    }
    return [super classForObjectsInArrayWithKey:key];
}

@end

@implementation FLResultsModel

@end
