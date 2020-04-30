//
//  BubbleSort.m
//  EPAM-HW03-2
//
//  Created by Eric Golovin on 01.05.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import "BubbleSort.h"

@implementation BubbleSort {
    int totalBytesUsed;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        totalBytesUsed = 0;
    }
    return self;
}

- (NSMutableArray *)bubbleSortArray:(NSMutableArray *)unsortedArray {
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:unsortedArray];
    
    for (int index = 0; index < [resultArray count] - 1; index++) {
        for (int subIndex = 0; subIndex < [resultArray count] - index - 1; subIndex++) {
            if ([resultArray objectAtIndex:subIndex] > [resultArray objectAtIndex:subIndex + 1]) {
                [resultArray exchangeObjectAtIndex:subIndex withObjectAtIndex:subIndex + 1];
            }
            totalBytesUsed += sizeof(subIndex);
        }
        totalBytesUsed += sizeof(index);
    }
    totalBytesUsed += sizeof(resultArray);
    
    return resultArray;
}

- (int)getTotalBytes {
    return totalBytesUsed;
}

@end
