//
//  main.m
//  EPAM-HW03-2
//
//  Created by Eric Golovin on 29.04.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Binary.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDate *startTime = [NSDate date];
        Binary *binary = [Binary new];
        
        for (int i = 0; i < 10000; i++) {
            [binary addNumber:@(arc4random_uniform(200000) - 100000)];
        }
        
        [binary quickSortArray:[binary getIntegers]];
        
        NSDate *endTime = [NSDate date];
        NSTimeInterval executionTime = [endTime timeIntervalSinceDate: startTime];
        NSLog(@"Timing: %f", executionTime);
        
        // TODO: This does not work, try to recode
        NSLog(@"Size: %i", [binary getTotalBytes] / 8);
        
        printf("\n");
    }
    return 0;
}
