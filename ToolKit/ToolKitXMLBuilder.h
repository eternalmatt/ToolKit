//
//  ToolKitXMLBuilder.h
//  ToolKit
//
//  Created by Matt Senn on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolKitXMLBuilder : NSObject

-(id)init;
-(void)addCamera:(UIImage*)image;
-(void)addGPS:(NSArray*)data;
-(void)addTextInput:(NSArray*)data;
-(void)addAcceleration:(NSArray*)data;

-(NSString*)generateXML;


@end
