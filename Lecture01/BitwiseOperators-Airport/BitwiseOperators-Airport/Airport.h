//
//  Airport.h
//  BitwiseOperators-Airport
//
//  Created by Eric Golovin on 13.04.2020.
//  Copyright © 2020 EPAM-University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import "Plane.h"

NS_ASSUME_NONNULL_BEGIN

@interface Airport : NSObject

@property (readonly) NSString *name;
@property (readonly) Address *address;
@property NSArray* planes;

-(instancetype) initWithName:(NSString*)name andAddress:(Address*)address;
-(void) addPlane:(Plane*)newPlane;

@end

NS_ASSUME_NONNULL_END
