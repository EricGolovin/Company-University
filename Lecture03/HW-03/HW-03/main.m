//
//  main.m
//  HW-03
//
//  Created by Eric Golovin on 01.05.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinarySearch.h"
#import "LinearSearch.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BinarySearch *binarySearch = [[BinarySearch alloc] init];
        LinearSearch *linearSearch = [[LinearSearch alloc] init];
        NSMutableArray *arrayOfNSNums = [NSMutableArray array];
        
        for (int i = 0; i < 10000; i++) {
//            [arrayOfNSNums addObject:@(arc4random_uniform(200000) - 100000)];
            [arrayOfNSNums addObject:@(arc4random_uniform(10000))];
        }
        
        [arrayOfNSNums sortUsingComparator: ^(id obj1, id obj2) {
            if ([obj1 intValue] > [obj2 intValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else  if ([obj1 intValue] < [obj2 intValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDate *startTime = [NSDate date];
        NSInteger binarySearchResult = [binarySearch binarySearch:@14 minIndex:0 maxIndex:[arrayOfNSNums count] in:arrayOfNSNums];
        NSDate *endTime = [NSDate date];
        
        NSTimeInterval executionTime = [endTime timeIntervalSinceDate: startTime];
        NSLog(@"BinarySearch Timing: %f Result: %ld", executionTime, (long)binarySearchResult);
        // TODO: This does not work, try to recode
        NSLog(@"BinarySearch Size: %f", (double)[binarySearch getTotalBytes] / 8000000.0);
        printf("\n");
        
        startTime = [NSDate date];
        NSInteger linearSearchResult = [linearSearch linearSearchFor:@4 in:arrayOfNSNums];
        endTime = [NSDate date];
        
        executionTime = [endTime timeIntervalSinceDate: startTime];
        NSLog(@"LinearSearch Timing: %f Result: %ld", executionTime, (long)linearSearchResult);
        // TODO: This does not work, try to recode
        NSLog(@"LinearSearch Size: %f", (double)[linearSearch getTotalBytes] / 8000000.0);
        printf("\n");
    }
    return 0;
}
