//
//  FLTask.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLTask.h"

@interface FLTask()

@property (nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation FLTask

- (instancetype)initWithDataTask:(NSURLSessionDataTask *)dataTask {
    self = [super init];
    if (self) {
        _dataTask = dataTask;
    }
    return self;
}


- (void)cancel {
    [self.dataTask cancel];
}

@end
