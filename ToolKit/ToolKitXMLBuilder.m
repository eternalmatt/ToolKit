//
//  ToolKitXMLBuilder.m
//  ToolKit
//
//  Created by Matt Senn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ToolKitXMLBuilder.h"
#import "NSString+Base64.h"
#import <MapKit/MapKit.h>
#import "NSData+Base64.h"

@interface ToolKitXMLBuilder()
+(DDXMLElement*)basicRoot;
@property (nonatomic, strong) DDXMLElement *xmlRoot;
@property (nonatomic, strong) DDXMLElement *files;
@end

@implementation ToolKitXMLBuilder
@synthesize xmlRoot, files;

+(DDXMLElement*)basicRoot
{
    DDXMLElement *root = [DDXMLElement elementWithName:@"toolkitxml"];    
    
    DDXMLNode *attribute = [DDXMLNode attributeWithName:@"id" 
                                            stringValue:[NSString stringWithFormat:@"%d", 1]];
    [root addChild:[DDXMLNode elementWithName:@"submittedCampaign"
                                     children:nil
                                   attributes:[NSArray arrayWithObject:attribute]]];
    
    attribute = [DDXMLNode attributeWithName:@"id" 
                                 stringValue:[NSString stringWithFormat:@"%d", 1]];
    [root addChild:[DDXMLNode elementWithName:@"submittinguser" 
                                     children:nil
                                   attributes:[NSArray arrayWithObject:attribute]]];
    return root;
}

-(NSString*)writeToFile:(NSString*)fileName withString:(NSString*)string
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileNameWithPath = [NSString stringWithFormat:@"%@/%@.xml", documentsDirectory, fileName];
    
    
    //save content to the documents directory
    [string writeToFile:fileNameWithPath
             atomically:YES
               encoding:NSStringEncodingConversionAllowLossy 
                  error:nil];
    return fileNameWithPath;
}

-(id)init
{
    if (self = [super init])
    {    
        DDXMLElement *root = [DDXMLElement elementWithName:@"toolkitxml"];
        [root addChild:[DDXMLNode elementWithName:@"Action" 
                                      stringValue:@"submitteddata"]];
        
        DDXMLNode *attribute = [DDXMLNode attributeWithName:@"id" 
                                                stringValue:[NSString stringWithFormat:@"%d", 1]];
        [root addChild:[DDXMLNode elementWithName:@"submittedCampaign"
                                         children:nil
                                       attributes:[NSArray arrayWithObject:attribute]]];
        
        attribute = [DDXMLNode attributeWithName:@"id" 
                                     stringValue:[NSString stringWithFormat:@"%d", 1]];
        [root addChild:[DDXMLNode elementWithName:@"submittinguser" 
                                         children:nil
                                       attributes:[NSArray arrayWithObject:attribute]]];
        
        self.files = [DDXMLElement elementWithName:@"files"];
        [root addChild:files];
        self.xmlRoot = root;
    }
    return self;
}

-(void)addAcceleration:(NSArray *)data
{
    if (nil == data) return;
    
    NSString *precision = @"%.5f";
    NSMutableString *xs = [NSMutableString stringWithCapacity:data.count];
    NSMutableString *ys = [NSMutableString stringWithCapacity:data.count];
    NSMutableString *zs = [NSMutableString stringWithCapacity:data.count];
    for(UIAcceleration* acceleration in data)
    {
        [xs appendFormat:precision, acceleration.x];
        [ys appendFormat:precision, acceleration.y];
        [zs appendFormat:precision, acceleration.z];
    }
    
    DDXMLElement *xsNode = [DDXMLElement elementWithName:@"X" stringValue:xs];
    DDXMLElement *ysNode = [DDXMLElement elementWithName:@"Y" stringValue:ys];
    DDXMLElement *zsNode = [DDXMLElement elementWithName:@"Z" stringValue:zs];
    NSArray *children = [NSArray arrayWithObjects:xsNode, ysNode, zsNode, nil];
    
    DDXMLElement *node = [DDXMLElement elementWithName:@"Acceleration" 
                                              children:children 
                                            attributes:nil];
    
    DDXMLElement *root = [ToolKitXMLBuilder basicRoot];
    [root addChild:node];
    
    NSString *filePath = [self writeToFile:@"acceleration" withString:[root XMLString]];
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSData *fileData = [manager contentsAtPath:filePath];
    NSString *string = [NSString base64StringFromData:fileData length:fileData.length];
    
    DDXMLElement *child = [DDXMLElement elementWithName:@"acceleration" stringValue:string];
    [child addAttribute:[DDXMLElement elementWithName:@"attribute"]];
    
    [self.files addChild:child];
}

-(void)addCamera:(UIImage *)image
{
    if (nil == image) return;
    
    NSData *data = UIImagePNGRepresentation(image);
    NSString *string = [NSString base64StringFromData:data length:data.length];
    
    DDXMLElement *node = [DDXMLElement elementWithName:@"Camera" stringValue:string];
    [self.files addChild:node];
}

-(void)addGPS:(NSArray *)data
{
    if (nil == data) return;
    
    NSString *format = @", %.5f";
    NSMutableString *latitudes  = [NSMutableString stringWithCapacity:data.count];
    NSMutableString *longitudes = [NSMutableString stringWithCapacity:data.count];
    for(int i=0; i < data.count; i++)
    {
        CLLocation *location = [data objectAtIndex:i];
        if (i == 0)
        {
            [latitudes  appendFormat:@"%.5f", location.coordinate.latitude];
            [longitudes appendFormat:@"%.5f", location.coordinate.longitude];
        }else
        {
            [latitudes  appendFormat:format, location.coordinate.latitude];
            [longitudes appendFormat:format, location.coordinate.longitude];
        }
    }
    
    DDXMLElement *root = [ToolKitXMLBuilder basicRoot];
    DDXMLElement *latNode = [DDXMLElement elementWithName:@"DataType" stringValue:latitudes];
    [latNode addAttribute:[DDXMLNode attributeWithName:@"name" stringValue:@"Latitude"]];
    [root addChild:latNode];
    
    DDXMLElement *lonNode = [DDXMLElement elementWithName:@"DataType" stringValue:longitudes];
    [lonNode addAttribute:[DDXMLNode attributeWithName:@"name" stringValue:@"Longitude"]];
    [root addChild:lonNode];
    
    
    
    /* need to package root into a base64 XML file here and then put into fileNode */
    
    DDXMLElement *fileNode = [DDXMLElement elementWithName:@"SubmittedSensor"];
    [fileNode setStringValue:@"the base 64 string goes here"];
    [fileNode addAttribute:[DDXMLNode attributeWithName:@"type"     stringValue:@"text"]];
    [fileNode addAttribute:[DDXMLNode attributeWithName:@"fileName" stringValue:@"someFileName.xml"]];
    
    /* this will after do for now until I figure out xml -> file -> base64 */
    [fileNode addChild:root];
    
    
    [self.files addChild:fileNode];
}

-(void)addTextInput:(NSArray *)data
{
    if (nil == data) return;
    
    DDXMLElement *root = [ToolKitXMLBuilder basicRoot];
    NSArray *questionArray = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"TextInputTextBoxes"];
    for(int i=0; i < data.count; i++)
    {
        NSString *question = [questionArray objectAtIndex:i];
        NSString *answer = [data objectAtIndex:i];
        
        DDXMLElement *element = [DDXMLElement elementWithName:@"DataType"];
        [element addAttribute:[DDXMLNode attributeWithName:@"name" stringValue:question]];
        [element setStringValue:answer];
        
        [root addChild:element];
    }
    
    /* need to package root into a base64 XML file here and then put into fileNode */
    
    DDXMLElement *fileNode = [DDXMLElement elementWithName:@"SubmittedSensor"];
    [fileNode setStringValue:@"the base 64 string goes here"];
    [fileNode addAttribute:[DDXMLNode attributeWithName:@"type"     stringValue:@"text"]];
    [fileNode addAttribute:[DDXMLNode attributeWithName:@"fileName" stringValue:@"someFileName.xml"]];
    
    /* this will after do for now until I figure out xml -> file -> base64 */
    [fileNode addChild:root];
                        
    
    [self.files addChild:fileNode];
}

-(NSString*)generateXML
{
    return self.xmlRoot.XMLString;
}


@end
