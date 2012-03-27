//
//  CyclicArray.h
//  ToolKit
//
//  Created by Matt Senn on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CyclicArray : NSMutableArray
{
    NSInteger i;
}

@property (nonatomic) NSInteger modulus;
+(id)cyclicArrayWithModulus:(NSInteger)modulus;
-(void)addObject:(id)anObject;

@end
