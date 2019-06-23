//
//  FLCoreIO.m
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLCoreIO.h"

@interface FLCoreIO()

@property (nonatomic, readonly) NSString *cacheFolder;

@end

@implementation FLCoreIO
@synthesize cacheFolder = _cacheFolder;

- (NSData *)dataObjectForKey:(NSString *)key {
    NSString *filePath = [self.cacheFolder stringByAppendingPathComponent:key];
    return [NSData dataWithContentsOfFile:filePath];
}

- (NSDictionary *)dictionaryObjectForKey:(NSString *)key {
    NSString *filePath = [self.cacheFolder stringByAppendingPathComponent:key];
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}

- (void)storeObject:(id)object forKey:(NSString *)key {
    NSString *filePath = [self.cacheFolder stringByAppendingPathComponent:key];
    if (!object) {
        //remove
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        return;
    }
    
    //save to disk
    if ([object isKindOfClass:NSData.class]) {
        [(NSData *)object writeToFile:filePath options:NSDataWritingAtomic error:nil];
    } else {
        [(NSDictionary *)object writeToFile:filePath atomically:YES];
    }
}

- (NSString *)cacheFolder {
    if (!_cacheFolder) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _cacheFolder = [paths objectAtIndex:0];
    }
    return _cacheFolder;
}

@end
