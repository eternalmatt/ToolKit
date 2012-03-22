//
//  ToolKitXMLBuilder.m
//  ToolKit
//
//  Created by Matt Senn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ToolKitXMLBuilder.h"

@implementation ToolKitXMLBuilder

+(NSString*)createFileWithDictionary:(NSDictionary *)dictionary
{
    NSMutableString *file = [NSMutableString stringWithCapacity:1024];
    
    for (NSString *key in dictionary.allKeys)
    {
        [file appendFormat:@"<SubmittedSensor type=\"%@\">%@<\\SubmittedSensor>", key, [dictionary objectForKey:key]];
    }
    
    
    NSString *head;
    NSString *end;
    NSString *xml = [NSString stringWithFormat:@"%@%@%@", head, file, end];
    NSLog(@"xml is %@", xml);
    
    NSArray *pathList = [[NSFileManager defaultManager] URLsForDirectory:NSDownloadsDirectory inDomains:NSUserDomainMask];
    NSLog(@"Path lists are %@", pathList);
    NSURL *path = [pathList objectAtIndex:0];
    
    path = [path URLByAppendingPathComponent:@"sensor.xml"];
    
    
    NSError *error;
    NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingURL:path error:&error];
    [handle writeData:[NSData data]];
    
    return xml;
}

@end
