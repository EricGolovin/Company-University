//
//  Address.h
//  BitwiseOperators-Airport
//
//  Created by Eric Golovin on 13.04.2020.
//  Copyright © 2020 EPAM-University. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Address : NSObject

@property NSString *street, *postIndex, *city, *country;

-(instancetype) initWithStreet:(NSString*)street postIndex:(NSString*)postIndex city:(NSString*)city country:(NSString*)country;

@end

NS_ASSUME_NONNULL_END
