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
@property (nonatomic, strong) NSArray *textLabels;
@property (nonatomic, strong) NSArray *textInputs;
@end

@implementation TextInputView
@synthesize textLabels, textInputs;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.delegate = self;
        self.dataSource = self;
        
        NSDictionary *bundle = [[NSBundle mainBundle] infoDictionary];
        self.textLabels = [bundle objectForKey:@"TextInputTextBoxes"];
        
        
        const CGRect bounds = [[UIScreen mainScreen] bounds];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:textLabels.count];
        for(int i=0; i < textLabels.count; i++)
        {
            [array addObject:[[UITextView alloc] initWithFrame:bounds]];
        }
        self.textInputs = array;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.textLabels count];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [self.textLabels objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[self.textInputs objectAtIndex:indexPath.row] text];
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *parent = [self firstAvailableUIViewController];
    UIViewController *textInputController = [[UIViewController alloc] init];
    textInputController.title = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    UITextView *textView = [self.textInputs objectAtIndex:indexPath.row];
    [textInputController.view addSubview:textView];
    [parent.navigationController pushViewController:textInputController animated:YES];
}

@end





