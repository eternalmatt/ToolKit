//
//  TextInputView.m
//  ToolKit
//
//  Created by Matthew Senn on 3/25/12.
//  Copyright (c) 2012 UNC Charlotte. All rights reserved.
//

#import "TextInputView.h"
#import "UIView+UIKitCategories.h"

@interface TextInputView ()
@property (nonatomic, strong) NSArray *textFields;
@end

@implementation TextInputView
@synthesize textFields;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.delegate = self;
        self.dataSource = self;
        
        NSDictionary *bundle = [[NSBundle mainBundle] infoDictionary];
        self.textFields = [bundle objectForKey:@"TextInputTextBoxes"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.textFields count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"I really don't understand this.";
     
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [self.textFields objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end





