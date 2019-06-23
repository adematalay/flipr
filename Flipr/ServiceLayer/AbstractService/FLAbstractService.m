//
//  FLAbstractService.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLAbstractService.h"

@implementation FLAbstractService

- (instancetype)initWithNetworking:(id<FLNetworking>)networking
                        persisting:(id<FLPersisting>)persisting {
    self = [super init];
    if (self) {
        _networking = networking;
        _persisting = persisting;
    }
    return self;
}

@end
