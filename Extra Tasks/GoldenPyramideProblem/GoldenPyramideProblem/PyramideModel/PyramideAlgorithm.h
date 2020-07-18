//
//  PyramideAlgorithm.h
//  GoldenPyramideProblem
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PyramideAlgorithm : NSObject

@property (nonatomic, copy, readonly) NSArray *coordinates;
@property (nonatomic, readonly) NSNumber *weightOfRoute;

- (NSString *)findRouteInPyramide:(NSArray *)pyramide;
+ (void)printPyramide:(NSArray *)pyramide;

@end

NS_ASSUME_NONNULL_END
