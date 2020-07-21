//
//  PyramideAlgorithm.m
//  GoldenPyramideProblem
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import "PyramideAlgorithm.h"

@interface PyramideAlgorithm ()

@property (nonatomic) NSMutableArray *mutableCoordinates;

@end

@implementation PyramideAlgorithm {
    int weight;
}

- (NSString *)findRouteInPyramide:(NSArray *)pyramide {
    [self setMutableCoordinates:[NSMutableArray array]];
    weight = 0;
    
    NSMutableString *resultString = [NSMutableString string];
    NSDate *date = [NSDate date];
    if (pyramide.count > 0 && [[pyramide firstObject] isKindOfClass:[NSArray class]]) {
        
        [resultString appendString:[NSString stringWithFormat:@"%@ ", [[pyramide objectAtIndex:0] objectAtIndex:0]]];
        [_mutableCoordinates addObject:[NSArray arrayWithObjects:@0, @0, nil]];
        NSUInteger q = 0;
        
        for (int i = 0; i < pyramide.count - 1; i += 1) {
            
            NSNumber *secondLineFirstObject = [[pyramide objectAtIndex:(i+1)] objectAtIndex:q];
            NSNumber *secondLineSecondObject = [[pyramide objectAtIndex:(i+1)] objectAtIndex:(q+1)];
            
            if ([secondLineFirstObject compare:secondLineSecondObject] == NSOrderedDescending) {
                [resultString appendString:[NSString stringWithFormat:@"%@ ", [[pyramide objectAtIndex:(i+1)] objectAtIndex:q]]];
                
                [_mutableCoordinates addObject:[NSArray arrayWithObjects:@(q), nil]];
                
                NSNumber *number = [[pyramide objectAtIndex:(i+1)] objectAtIndex:q];
                weight += [number intValue];
            } else {
                [resultString appendString:[NSString stringWithFormat:@"%@ ", [[pyramide objectAtIndex:(i+1)] objectAtIndex:(q+1)]]];
                [_mutableCoordinates addObject:[NSArray arrayWithObjects:@(q+1), nil]];
                
                NSNumber *number = [[pyramide objectAtIndex:(i+1)] objectAtIndex:(q+1)];
                weight += [number intValue];
                q += 1;
            }
        }

        NSLog(@"%f", [date timeIntervalSinceNow]);
        
    }
    
    [resultString appendFormat:@" =sum= %i", weight];
    
    return resultString;
}

+ (void)printPyramide:(NSArray *)pyramide {
    for (int i = 0; i < pyramide.count; i += 1) {
        for (int q = 0; q < [[pyramide objectAtIndex:i] count]; q += 1) {
            printf("%i ", [[[pyramide objectAtIndex:i] objectAtIndex:q] intValue]);
        }
        printf("\n");
    }
}


- (NSArray *)coordinates {
    return [[self mutableCoordinates] copy];
}

- (NSNumber *)weightOfRoute {
    return [NSNumber numberWithInt:weight];
}

@end
