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
    // If the subarray is empty, return not found
    if (maxIndex < minIndex) {
        return NSNotFound;
    }
    
    NSInteger midIndex = (minIndex + maxIndex) / 2;
    NSNumber *itemAtMidIndex = [array objectAtIndex:midIndex];
    
    NSComparisonResult comparison = [searchItem compare:itemAtMidIndex];
    if (comparison == NSOrderedSame) {
        return midIndex;
    } else if (comparison == NSOrderedAscending) {
        return [self binarySearch:searchItem minIndex:minIndex maxIndex:midIndex - 1 in:array];
    } else {
        return [self binarySearch:searchItem minIndex:midIndex + 1 maxIndex:maxIndex in:array];
    }
}

- (int)getTotalBytes {
    return totalBytesUsed;
}

@end
