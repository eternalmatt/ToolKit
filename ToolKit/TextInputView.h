//
//  TextInputView.h
//  ToolKit
//
//  Created by Matthew Senn on 3/25/12.
//  Copyright (c) 2012 UNC Charlotte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextInputView : UITableView < UITableViewDelegate, UITableViewDataSource >

-(NSArray*)textStringsFromUser;

@end
