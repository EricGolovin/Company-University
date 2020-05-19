//
//  main.m
//  EPAM-HW03-2
//
//  Created by Eric Golovin on 29.04.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickSort.h"
#import "BubbleSort.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *unsortedArray = [NSMutableArray array];
        NSMutableArray *sortedArray = [NSMutableArray array];
        QuickSort *quickSort = [QuickSort new];
        BubbleSort *bubbleSort = [BubbleSort new];
        
        NSDate *startTime = [NSDate date];
        for (int i = 0; i < 10000; i++) {
            [unsortedArray addObject:@(arc4random_uniform(200000) - 100000)];
        }
        
        sortedArray = [quickSort quickSortArray:unsortedArray];
        NSDate *endTime = [NSDate date];
        
        NSTimeInterval executionTime = [endTime timeIntervalSinceDate: startTime];
        NSLog(@"QuickSort Timing: %f", executionTime);
        
        // TODO: This does not work, try to recode
        NSLog(@"QuickSort Size: %f", (double)[quickSort getTotalBytes] / 8000000.0);
        printf("\n");
        
        startTime = [NSDate date];
        
        sortedArray = [bubbleSort bubbleSortArray:unsortedArray];
        endTime = [NSDate date];
        
        executionTime = [endTime timeIntervalSinceDate: startTime];
        NSLog(@"BubbleSort Timing: %f", executionTime);
        
        // TODO: This does not work, try to recode
        NSLog(@"BubbleSort Size: %f", (double)[bubbleSort getTotalBytes] / 8000000.0);
        
        printf("\n");
    }
    return 0;
}
