//
//  ToolKitXMLBuilder.m
//  ToolKit
//
//  Created by Matt Senn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ToolKitXMLBuilder.h"

@implementation ToolKitXMLBuilder

-(NSString*)createFileWithDictionary:(NSDictionary *)dictionary
{
    NSMutableString *file = [NSMutableString stringWithCapacity:1024];
    
    for (NSString *key in dictionary.allKeys)
    {
        [file appendFormat:@"<sensorOption=\"%@\">%@<\\sensorOption"];
    }
    
    
    NSString *head;
    NSString *end;
    return [NSString stringWithFormat:@"%@%@%@", head, file, end];
}

@end
