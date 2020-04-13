//
//  Airport.m
//  BitwiseOperators-Airport
//
//  Created by Eric Golovin on 13.04.2020.
//  Copyright © 2020 EPAM-University. All rights reserved.
//

#import "Airport.h"

@interface Airport()

@property NSString *name;
@property Address *address;

@end

@implementation Airport {
    NSMutableArray *planes;
}

@synthesize name, address, planes;

-(instancetype) initWithName:(NSString *)name andAddress:(Address *)address {
    self = [super init];
    if (self) {
        [self setName:name];
        [self setAddress:address];
        planes = [NSMutableArray array];
    }
    return self;
}


// TODO: Do not add exisitng planes
-(void) addPlane:(Plane*)newPlane {
    [planes addObject:newPlane];
}

@end
