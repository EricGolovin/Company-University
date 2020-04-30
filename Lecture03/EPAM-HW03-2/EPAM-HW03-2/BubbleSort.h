//
//  BubbleSort.h
//  EPAM-HW03-2
//
//  Created by Eric Golovin on 01.05.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BubbleSort : NSObject

- (instancetype)init;
- (NSMutableArray *)bubbleSortArray:(NSMutableArray *)unsortedArray;
- (int)getTotalBytes;

@end

NS_ASSUME_NONNULL_END
