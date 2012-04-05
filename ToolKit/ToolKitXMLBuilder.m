//
//  ToolKitXMLBuilder.m
//  ToolKit
//
//  Created by Matt Senn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ToolKitXMLBuilder.h"
#import "DDXML.h"
#import "NSString+Base64.h"
#import <MapKit/MapKit.h>

@interface ToolKitXMLBuilder()
@property (nonatomic, strong) DDXMLElement *xmlRoot;
@end

@implementation ToolKitXMLBuilder
@synthesize xmlRoot;

-(id)init
{
    if (self = [super init])
    {
        self.xmlRoot = [DDXMLElement elementWithName:@"ToolKit"];
        
        
    }
    return self;
}

-(void)addAcceleration:(NSArray *)data
{
    if (nil == data) return;
    
    DDXMLNode *node = [DDXMLElement elementWithName:@"Acceleration" children:data attributes:nil];
    [self.xmlRoot addChild:node];
}

-(void)addCamera:(UIImage *)image
{
    if (nil == image) return;
    
    NSData *data = UIImagePNGRepresentation(image);
    NSString *string = [NSString base64StringFromData:data length:data.length];
    
    DDXMLElement *node = [DDXMLElement elementWithName:@"Camera" stringValue:string];
    [self.xmlRoot addChild:node];
}

-(void)addGPS:(NSArray *)data
{
    if (nil == data) return;
    
    NSMutableArray *latitudes = [NSMutableArray arrayWithCapacity:data.count];
    NSMutableArray *longitudes = [NSMutableArray arrayWithCapacity:data.count];
    for(CLLocation *location in data)
    {
        [latitudes addObject:[NSString stringWithFormat:@"%.5f", location.coordinate.latitude]];
        [longitudes addObject:[NSString stringWithFormat:@"%.5f", location.coordinate.longitude]];
    }
    
    DDXMLElement *node = [DDXMLElement elementWithName:@"GPS"];
    DDXMLElement *latNode = [DDXMLElement elementWithName:@"Latitude" stringValue:[latitudes description]];
    DDXMLElement *lonNode = [DDXMLElement elementWithName:@"Longitude" stringValue:[longitudes description]];
    
    [node addChild:latNode];
    [node addChild:lonNode];
    [self.xmlRoot addChild:node];
}

-(void)addTextInput:(NSArray *)data
{
    if (nil == data) return;
    
    DDXMLElement *node = [DDXMLElement elementWithName:@"TextInput"];
    for(NSString *string in data)
        [node addChild:[DDXMLElement elementWithName:@"Question" stringValue:@"Answer"]];
    
    [self.xmlRoot addChild:node];
}

-(NSString*)generateXML
{
    return self.xmlRoot.XMLString;
}


@end
