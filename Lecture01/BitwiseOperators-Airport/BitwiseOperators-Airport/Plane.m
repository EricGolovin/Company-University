//
//  Plane.m
//  BitwiseOperators-Airport
//
//  Created by Eric Golovin on 13.04.2020.
//  Copyright © 2020 EPAM-University. All rights reserved.
//

#import "Plane.h"

@interface Plane()

@property NSString *model;
@property FlightDurationOptions duration;

@end

@implementation Plane

@synthesize model, duration;

-(instancetype) initWithModel:(NSString *)model duration:(FlightDurationOptions)duration {
    self = [super init];
    if (self) {
        [self setModel:model];
        [self setDuration:duration];
    }
    return self;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"Plane:\n\t-Model: %@\n\t-Duration: %x", [self model], [self duration]];
}

@end
