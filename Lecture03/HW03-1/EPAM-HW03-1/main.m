//
//  main.m
//  EPAM-HW03-1
//
//  Created by Eric Golovin on 28.04.2020.
//  Copyright © 2020 com.ericgolovin-university. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *firstArray = [NSArray arrayWithObjects: @"String", @2, nil];
        NSArray *literalFirstArray = @[@"String", @2];
        
        NSDictionary *firstDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"First",@1, @"Second", @2, nil];
        NSDictionary *literalFirstDictionary = @{@"First" : @1, @"Second" : @2};
        
        for (id object in literalFirstArray) {
            NSLog(@"%@", object);
        }
        
        for (NSString *object in literalFirstDictionary) {
            NSLog(@"Key[%@] = %@", object, [literalFirstDictionary objectForKey:object]);
        }
    }
    return 0;
}
