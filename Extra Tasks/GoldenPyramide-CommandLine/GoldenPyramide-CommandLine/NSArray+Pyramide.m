//
//  NSArray+Pyramide.m
//  GoldenPyramide-CommandLine
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import "NSArray+Pyramide.h"

@implementation NSArray (Pyramide)

+ (NSArray*)getPyramideOfSize:(unsigned int)value {
    NSMutableArray* mutablePyramide = [NSMutableArray array];
    
    for (int i = value - 1; i >= 0; i -= 1) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int q = 0; q < value - i; q += 1) {
            NSNumber *randomNum = [NSNumber numberWithInt:arc4random_uniform(9)];
            [rowArray addObject:randomNum];
        }
        [mutablePyramide addObject:rowArray];
    }
    
    return mutablePyramide;
}

- (void)findHeaviestRouteAndPrint {
    NSMutableString *resultString = [NSMutableString string];
    if (self.count > 0 && [[self firstObject] isKindOfClass:[NSArray class]]) {
//        [self formTriangle];
        [resultString appendString:[NSString stringWithFormat:@"%@ ", [[self objectAtIndex:0] objectAtIndex:0]]];
        NSUInteger q = 0;
        for (int i = 0; i < self.count - 1; i += 1) {
//            NSUInteger upperBound = [[self objectAtIndex:i] count];
            
            NSNumber *secondLineFirstObject = [[self objectAtIndex:(i+1)] objectAtIndex:q];
            NSNumber *secondLineSecondObject = [[self objectAtIndex:(i+1)] objectAtIndex:(q+1)];
            
            if ([secondLineFirstObject compare:secondLineSecondObject] == NSOrderedDescending) {
                [resultString appendString:[NSString stringWithFormat:@"%@ ", [[self objectAtIndex:(i+1)] objectAtIndex:q]]];
            } else {
                [resultString appendString:[NSString stringWithFormat:@"%@ ", [[self objectAtIndex:(i+1)] objectAtIndex:(q+1)]]];
                q += 1;
            }
//            for (int q = 0; q < upperBound; q += 1) {
//                NSLog(@"\ni = %lu\nq = %i", i, q);
//
//
//            }
        }
    }
    
    NSLog(@"%@", resultString);
}

- (void)formTriangle {
    if (self.count > 0 && [[self firstObject] isKindOfClass:[NSArray class]]) {
        int largestCount = (int)[[self lastObject] count];
        for (int i = 0; i < self.count; i++) {
            int numberOfZeros = largestCount - (int)[[self objectAtIndex:i] count];
            for (int q = 0; q < numberOfZeros; q++) {
                // TODO: Remove when complete algorithm
                NSLog(@"NUM: %i ; q = %i", largestCount - (int)[[self objectAtIndex:i] count], q);
                [[self objectAtIndex:i] addObject:@0];
            }
        }
    }
    [self printPyramide];
}

- (void)printPyramide {
    for (int i = 0; i < self.count; i += 1) {
        for (int q = 0; q < [[self objectAtIndex:i] count]; q += 1) {
            printf("%i ", [[[self objectAtIndex:i] objectAtIndex:q] intValue]);
        }
        printf("\n");
    }
}

@end
