//
//  FLDataModel.m
//  Flipr
//
//  Created by Adem Atalay on 20.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLDataModel.h"
@import ObjectiveC.runtime;

@interface FLDataModel()

@end

@implementation FLDataModel
@synthesize dictionaryRepresentation = _dictionaryRepresentation;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (!dictionary) {
        return nil;
    }
    
    self = [super init];
    if(self){
        _dictionaryRepresentation = [dictionary copy];
        for(NSString *key in dictionary.allKeys){
            if([self respondsToSelector:NSSelectorFromString(key)]) {
                id value = dictionary[key];
                if ([value isKindOfClass:NSDictionary.class]) {
                    //The object should be same kind of model to be initialized in same way
                    objc_property_t property = class_getProperty([self class], [key UTF8String]);
                    NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
                    NSString *className = [propertyAttributes componentsSeparatedByString:@"\""][1];
                    
                    [self setValue:[[NSClassFromString(className) alloc] initWithDictionary:value] forKey:key];
                } else if ([value isKindOfClass:NSArray.class]) {
                    //The object inside of an array should be same kind of model to be initialized in same way
                    Class arrayObj = [self.class classForObjectsInArrayWithKey:key];
                    NSMutableArray *arr = NSMutableArray.new;
                    for (NSDictionary *subDict in value) {
                        [arr addObject:[[arrayObj alloc] initWithDictionary:subDict]];
                    }
                    [self setValue:arr.copy forKey:key];
                } else {
                    // Foundation type
                    [self setValue:dictionary[key] forKey:key];
                }
            }
        }
    }
    return self;
}

- (Class)classForObjectsInArrayWithKey:(NSString *)key {
    return NSString.class;
}

- (id)copyWithZone:(NSZone *)zone{
    return [[self.class alloc] initWithDictionary:self.dictionaryRepresentation];
}

- (NSString *)description{
    NSString *d = [super description];
    
    return [d stringByAppendingFormat:@" %@", self.dictionaryRepresentation];
}

@end
