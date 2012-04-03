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
    DDXMLNode *node = [DDXMLElement elementWithName:@"Acceleration" children:data attributes:nil];
    [self.xmlRoot addChild:node];
}

-(void)addCamera:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    DDXMLElement *node = [DDXMLElement elementWithName:@"Camera"];
    [node setChildren:[NSArray arrayWithObject:[NSString base64StringFromData:data length:data.length]]];
    [self.xmlRoot addChild:node];
}

-(void)addGPS:(NSArray *)data
{
    NSMutableArray *latitudes = [NSMutableArray arrayWithCapacity:data.count];
    NSMutableArray *longitudes = [NSMutableArray arrayWithCapacity:data.count];
    for(CLLocation *location in data)
    {
        [latitudes addObject:[NSString stringWithFormat:@"%.5f", location.coordinate.latitude]];
        [longitudes addObject:[NSString stringWithFormat:@"%.5f", location.coordinate.longitude]];
    }
    
    DDXMLNode *node = [DDXMLElement elementWithName:@"GPS"
                                           children:[NSArray arrayWithObjects:latitudes, longitudes, nil]
                                         attributes:nil];
    [self.xmlRoot addChild:node];
}

-(void)addTextInput:(NSArray *)data
{
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
