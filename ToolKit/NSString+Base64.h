//
//  NSString+Base64.h
//  ToolKit
//
//  Created by Matt Senn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+(NSString *)base64StringFromData:(NSData *)data 
                           length:(int)length;

@end
