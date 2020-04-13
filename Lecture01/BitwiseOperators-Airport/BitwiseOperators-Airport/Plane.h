//
//  Plane.h
//  BitwiseOperators-Airport
//
//  Created by Eric Golovin on 13.04.2020.
//  Copyright © 2020 EPAM-University. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(int, FlightDurationOptions) {
    tooShort = 1 << 0,
    tooNormal = 1 << 3,
    tooLong = 1 << 2
};

@interface Plane : NSObject

@property (readonly) NSString *model;
@property (readonly) FlightDurationOptions duration;

-(instancetype) initWithModel:(NSString*)model duration:(FlightDurationOptions)duration;

@end

NS_ASSUME_NONNULL_END
