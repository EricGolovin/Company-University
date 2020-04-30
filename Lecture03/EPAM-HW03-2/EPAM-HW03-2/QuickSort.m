//
//  Binary.m
//  EPAM-HW03-2
//
//  Created by Eric Golovin on 29.04.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort {
    int totalBytesUsed;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        totalBytesUsed = 0;
    }
    
    return self;
}

- (NSMutableArray *) quickSortArray:(NSMutableArray *)unsortedArray {
 
    // Time complexity: O(n^2).
    //  * First time arround is to separate the entire array.
    //  * Second time around should sort the rest of the array.
    // Space complexity: O(log n)  +1 for unsortedArray but the mutable copy never gets added to the autorelease pool.
    // All of the arrays that are not attached to the returnArray are released by a compiler pass at the end of the method.
 
    int count = (int)[unsortedArray count];
    totalBytesUsed += sizeof(count);
    if (count <= 1) {
        return unsortedArray;
    }
 
    int pivot = [[unsortedArray objectAtIndex: (count/2)] intValue];
    totalBytesUsed += sizeof(pivot);
    NSMutableArray *smallerThanArray = [NSMutableArray array];
    NSMutableArray *largerThanArray = [NSMutableArray array];
    NSMutableArray *pivotArray = [NSMutableArray array];
    [pivotArray addObject: @(pivot)];
    for (int e = 0; e < count; e++) {
        int num = [[unsortedArray objectAtIndex:e] intValue];
 
        if (num < pivot) {
            [smallerThanArray addObject: @(num)];
        } else if (num > pivot) {
            [largerThanArray addObject: @(num)];
            // To address the possibly duplicate that is defined in the pivot, in this case 4.
        } else if (e != (count/2) && pivot == num) {
            [pivotArray addObject: @(num)];
        }
    }
    
    totalBytesUsed += sizeof(smallerThanArray);
    totalBytesUsed += sizeof(largerThanArray);
    totalBytesUsed += sizeof(pivotArray);
 
    NSMutableArray *returnArray = [NSMutableArray array];
    [returnArray addObjectsFromArray: [self quickSortArray: smallerThanArray]];
    [returnArray addObjectsFromArray: pivotArray];
    [returnArray addObjectsFromArray: [self quickSortArray: largerThanArray]];
 
    totalBytesUsed += sizeof(returnArray);
    
    return returnArray;
}

- (int)getTotalBytes {
    return totalBytesUsed;
}

@end
