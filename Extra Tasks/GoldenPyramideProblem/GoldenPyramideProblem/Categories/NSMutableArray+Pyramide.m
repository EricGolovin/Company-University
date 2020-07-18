//
//  NSMutableArray+Pyramide.m
//  GoldenPyramideProblem
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import "NSMutableArray+Pyramide.h"

@implementation NSMutableArray (Pyramide)

- (instancetype)initWithPyramideSize:(int)size {
    self = [self init];
    
    if (self) {
        for (int i = size - 1; i >= 0; i -= 1) {
            NSMutableArray *rowArray = [NSMutableArray array];
            for (int q = 0; q < size - i; q += 1) {
                NSNumber *randomNum = [NSNumber numberWithInt:arc4random_uniform(9)];
                [rowArray addObject:randomNum];
            }
            [self addObject:rowArray];
        }
    }
    
    return self;
}

@end
