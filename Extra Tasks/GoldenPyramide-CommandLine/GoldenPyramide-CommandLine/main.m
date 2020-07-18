//
//  main.m
//  GoldenPyramide-CommandLine
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+Pyramide.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *pyramide = [NSArray getPyramideOfSize:5];
        
        [pyramide printPyramide];
        [pyramide findHeaviestRouteAndPrint];
    }
    return 0;
}
