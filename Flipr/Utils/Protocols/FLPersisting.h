//
//  FLPersisting.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

@import Foundation;

@protocol FLPersisting <NSObject>

/**
 * @brief Gatherd data from provided key/path, data can be different type according to implementation
 *
 * @param key path for data
 *
 * @return NSData data, can be nil
 */
- (NSData *)dataObjectForKey:(NSString *)key;

/**
 * @brief Gatherd data from provided key/path, data can be different type according to implementation
 *
 * @param key path for data
 *
 * @return NSDictionary dictionary, can be nil
 */
- (NSDictionary *)dictionaryObjectForKey:(NSString *)key;

/**
 * @brief saves the object to path
 *
 * @param object can be any serilizable or data object which will be saved to given path
 * @param key NSString file path will be used as file name in a default directory
 */
- (void)storeObject:(id)object forKey:(NSString *)key;

@end
