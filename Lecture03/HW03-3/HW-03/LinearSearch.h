//
//  LinearSearch.h
//  HW-03
//
//  Created by Eric Golovin on 01.05.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinearSearch : NSObject

- (instancetype)init;
- (NSInteger)linearSearchFor:(NSNumber *)num in:(NSMutableArray *)array;
- (int)getTotalBytes;

@end

NS_ASSUME_NONNULL_END
