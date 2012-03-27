//
//  CyclicArray.m
//  ToolKit
//
//  Created by Matt Senn on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CyclicArray.h"

@implementation CyclicArray
@synthesize modulus;

+(id)cyclicArrayWithModulus:(NSInteger)modulus
{
    CyclicArray *array = [NSMutableArray arrayWithCapacity:modulus];
    array.modulus = modulus;
    return array;
}

-(void)addObject:(id)anObject
{
    if ([self objectAtIndex:i] == nil)
        [self addObject:anObject];
    else
        [self replaceObjectAtIndex:i withObject:anObject];    
     
    i = ++i % modulus;
}

@end
