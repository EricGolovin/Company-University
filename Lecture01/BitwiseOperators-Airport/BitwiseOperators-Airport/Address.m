//
//  Address.m
//  BitwiseOperators-Airport
//
//  Created by Eric Golovin on 13.04.2020.
//  Copyright © 2020 EPAM-University. All rights reserved.
//

#import "Address.h"

@implementation Address

@synthesize street, postIndex, city, country;

-(instancetype) initWithStreet:(NSString *)street postIndex:(NSString *)postIndex city:(NSString *)city country:(NSString *)country {
    self = [super init];
    if (self) {
        [self setStreet:street];
        [self setPostIndex:postIndex];
        [self setCity:city];
        [self setCountry:country];
    }
    return self;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"Address:\n\t-Street: %@\n\t-PostIndex: %@\n\t-City: %@\n\t-Country: %@", [self street], [self postIndex], [self city], [self country]];
}

@end
