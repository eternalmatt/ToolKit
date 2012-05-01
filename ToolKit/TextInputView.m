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
@property (nonatomic, strong) NSMutableArray *textInputs;
@property (nonatomic, strong) UIViewController *textInputController;
@property (nonatomic, strong, retain)   UITextView *textView;
@property (nonatomic) NSUInteger row;
@property (nonatomic, strong) NSString *textInputSaveButton;
@end

@implementation TextInputView
@synthesize textLabels, textInputs, textInputController, textView, row, textInputSaveButton;

-(NSArray*)textStringsFromUser
{
    return self.textInputs;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = self;
        self.dataSource = self;
        
        NSDictionary *bundle = [[NSBundle mainBundle] infoDictionary];
        self.textLabels = [bundle objectForKey:@"TextInputTextBoxes"];
        self.textInputSaveButton = [bundle objectForKey:@"TextInputSaveButton"];
        
        
        self.textInputs = [NSMutableArray arrayWithCapacity:textLabels.count];
        for(int i=0; i < textLabels.count; i++)
            [self.textInputs addObject:[NSString string]];
        
        
        self.textInputController = [[UIViewController alloc] init];
        
        CGRect bounds = [[UIScreen mainScreen] bounds];
        
        UIButton *save = [UIButton buttonWithType:UIButtonTypeRoundedRect];   
        save.frame = CGRectMake(bounds.origin.x+20, bounds.origin.y+10, bounds.size.width-40, 30);
        save.titleLabel.textAlignment = UITextAlignmentCenter;
        [save setTitle:self.textInputSaveButton forState:UIControlStateNormal];
        [save addTarget:self 
                 action:@selector(saveText) 
       forControlEvents:UIControlEventTouchUpInside];
        [textInputController.view addSubview:save];
         
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y+50, bounds.size.width, bounds.size.height-50)];
        self.textView.font = [UIFont fontWithName:@"Helvetica" size:20];
        [textInputController.view addSubview:textView];
        
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
        cell.userInteractionEnabled = YES;
    }
    
    cell.textLabel.text = [self.textLabels objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.textInputs objectAtIndex:indexPath.row];
    if (indexPath.row == row)
    {
        cell.detailTextLabel.text = self.textView.text;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.row = indexPath.row;
    textInputController.title = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    textView.text = [self.textInputs objectAtIndex:row];
    
    UIViewController *parent = [self firstAvailableUIViewController];
    [parent.navigationController pushViewController:textInputController animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)saveText
{
    [self.textInputs replaceObjectAtIndex:row withObject:textView.text];
    [self reloadData];
}

@end





