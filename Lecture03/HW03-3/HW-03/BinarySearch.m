//
//  BinarySearch.m
//  HW-03
//
//  Created by Eric Golovin on 01.05.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import "BinarySearch.h"

@implementation BinarySearch {
    int totalBytesUsed;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        totalBytesUsed = 0;
    }
    return self;
}

- (NSInteger)binarySearch:(NSNumber *)searchItem minIndex:(NSInteger)minIndex maxIndex:(NSInteger)maxIndex in:(NSMutableArray *)array {
    while (minIndex < maxIndex) {
        NSInteger middle = minIndex + (maxIndex - 1) / 2;
        
        if ([[array objectAtIndex:middle] intValue] == [searchItem intValue]) {
            return middle;
        }
        
        if ([[array objectAtIndex:middle] intValue] < [searchItem intValue]) {
            minIndex = middle + minIndex;
        } else {
            maxIndex = middle - minIndex;
        }
    }
    return -1;
}

- (int)getTotalBytes {
    return totalBytesUsed;
}

@end
