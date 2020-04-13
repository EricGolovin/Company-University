//
//  main.m
//  BitwiseOperators-Airport
//
//  Created by Eric Golovin on 13.04.2020.
//  Copyright © 2020 EPAM-University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Airport.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Airport *londonAirport = [[Airport alloc] initWithName:@"Heathrow" andAddress:[[Address alloc] initWithStreet:@"Nelson Road" postIndex:@"TW6" city:@"Longford" country:@"United Kingdom"]];
        
        // setting airport adress
        NSLog(@"%@", [londonAirport address]);
        
        // setting airport planes
        for (int i = 0; i < 10; i++) {
            int randomInteger = arc4random_uniform(90);
            
            FlightDurationOptions dur;
            if (randomInteger < 30) {
                dur = tooShort;
            } else if (randomInteger < 60) {
                dur = tooShort | tooNormal;
            } else {
                dur = tooShort | tooNormal | tooLong;
            }
            
            if (dur & tooShort) {
                NSLog(@"Too short");
            } else if (dur & tooNormal) {
                NSLog(@"Too short too normal");
            } else {
                NSLog(@"Too short too normal too long");
            }
            
            Plane *somePlane = [[Plane alloc] initWithModel:[NSString stringWithFormat:@"MD-%i", randomInteger] duration:dur];
            
            /*
             (FlightDurationOptions)^(void) {
                 if (randomInteger < 30) {
                     return tooShort;
                 } else if (randomInteger < 60) {
                     return tooShort | tooNormal;
                 } else {
                     return tooShort | tooNormal | tooLong;
                 }
             }
             */
            
            [londonAirport addPlane: somePlane];
        }
        for (Plane *plane in [londonAirport planes]) {
            NSLog(@"%@", plane);
        }
        
    }
    return 0;
}
