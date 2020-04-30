//
//  Binary.h
//  EPAM-HW03-2
//
//  Created by Eric Golovin on 29.04.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Binary : NSObject

- (instancetype)init;
- (NSArray *)quickSortArray:(NSArray *)unsortedArray;
- (void)addNumber:(NSNumber *)number;
- (NSMutableArray *)getIntegers;
- (int) getTotalBytes;

@end

NS_ASSUME_NONNULL_END
