//
//  LinearSearch.m
//  HW-03
//
//  Created by Eric Golovin on 01.05.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import "LinearSearch.h"

@implementation LinearSearch {
    int totalBytesUsed;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        totalBytesUsed = 0;
    }
    return self;
}

- (NSInteger)linearSearchFor:(NSNumber *)num in:(NSMutableArray *)array {
    NSInteger counter = 0;
    for (NSNumber *number in array) {
        NSComparisonResult result = [number compare:num];
        if (result == NSOrderedSame) {
            return counter;
        } else {
            counter += 1;
        }
    }
    return -1;
}

- (int)getTotalBytes {
    return totalBytesUsed;
}

@end
