//
//  BubbleSort.m
//  EPAM-HW03-2
//
//  Created by Eric Golovin on 01.05.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import "BubbleSort.h"

@implementation BubbleSort
//{
//    int totalBytesUsed;
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        totalBytesUsed = 0;
    }
    return self;
}

- (NSMutableArray *)bubbleSortArray:(NSMutableArray *)unsortedArray {
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:unsortedArray];
    
    for (int i = 0; i < [resultArray count] - 1; i++) {
        for (int q = 0; q < [resultArray count] - i - 1; q++) {
            if ([resultArray objectAtIndex:q] > [resultArray objectAtIndex:q + 1]) {
//                [resultArray exchangeObjectAtIndex:q withObjectAtIndex:q + 1];
                NSNumber *temp = [unsortedArray objectAtIndex:q];
                [unsortedArray removeObjectAtIndex:q];
                [unsortedArray insertObject:temp atIndex:q + 1];
            }
            totalBytesUsed += sizeof(q);
        }
        totalBytesUsed += sizeof(i);
    }
    totalBytesUsed += sizeof(resultArray);
    
    return resultArray;
}

- (int)getTotalBytes {
    return totalBytesUsed;
}

@end
