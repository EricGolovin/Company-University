//
//  NSArray+Pyramide.h
//  GoldenPyramide-CommandLine
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Pyramide)

+ (NSArray*)getPyramideOfSize:(unsigned int)value;
- (void)findHeaviestRouteAndPrint;
- (void)printPyramide;

@end

NS_ASSUME_NONNULL_END
