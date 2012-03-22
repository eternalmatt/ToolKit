//
//  NSData+Base64.h
//  ToolKit
//
//  Created by Matt Senn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+(NSData *)base64DataFromString:(NSString *)string;

@end
