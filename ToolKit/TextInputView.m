//
//  TextInputView.m
//  ToolKit
//
//  Created by Matthew Senn on 3/25/12.
//  Copyright (c) 2012 UNC Charlotte. All rights reserved.
//

#import "TextInputView.h"

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
        
        
        NSDictionary *bundle = [[NSBundle mainBundle] infoDictionary];
        NSArray *textBoxes = [bundle objectForKey:@"TextInputTextBoxes"];
        
        NSUInteger count = textBoxes.count;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
        
        CGFloat x = 10;
        CGFloat y = -30;
        CGFloat width = frame.size.width - 20;
        CGFloat height = 40;
        for (NSString *string in textBoxes) 
        {
            y += 10 + height;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            label.text            = string;
            label.textAlignment   = UITextAlignmentCenter;
            label.textColor       = [UIColor blackColor];
            label.backgroundColor = self.backgroundColor;
            [self addSubview:label];
            
            y += 10 + height;
            UITextView *view = [[UITextView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            [self addSubview:view];
        }
        self.textFields = array;
    }
    return self;
}

@end
