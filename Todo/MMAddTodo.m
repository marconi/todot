//
//  MMAddContact.m
//  Todo
//
//  Created by Marconi Moreto on 12/26/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import "MMAddTodo.h"
#import "MMMainWindowController.h"
#import "MMTodo.h"

@implementation MMAddTodo

@synthesize name = _name,
            description = _description,
            isShown = _isShown;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setIsShown:NO];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSColor *darkBackground = [NSColor colorWithCalibratedRed:44.0/255.0f green:44.0/255.0f blue:44.0/255.0f alpha:1.0f];
    [darkBackground set];
    NSRectFill([self bounds]);
}

- (void) awakeFromNib
{
    [_formTitle setTextColor:[NSColor whiteColor]];
    [_nameLabel setTextColor:[NSColor whiteColor]];
    [_descriptionLabel setTextColor:[NSColor whiteColor]];
}

#pragma mark -
#pragma mark ADD TODO FORM ACTIONS
#pragma -----------------------------------------------------------------------------------------------------------------------

- (void) resetFields
{
    [[self name] setStringValue:@""];
    [[self description] setStringValue:@""];
}

- (IBAction) okButtonPressed:(id)sender
{
    if ([[[self name] stringValue] isEqualToString:@""]) {
        [[self name] becomeFirstResponder];
        return;
    }
    
    if ([[[self description] stringValue] isEqualToString:@""]) {
        [[self description] becomeFirstResponder];
        return;
    }

    if ([delegate respondsToSelector:@selector(addTodo:)]) {
        MMTodo *newTodo = [[MMTodo alloc] initWithName:[[self name] stringValue] andDescription:[[self description] stringValue]];
        [delegate addTodo:newTodo];
        [newTodo release];
        newTodo = nil;
    }
    [self resetFields];
}

- (IBAction) cancelButtonPressed:(id)sender
{
    if ([delegate respondsToSelector:@selector(hideAddTodoForm)]) {
        [delegate hideAddTodoForm];
    }
    [self resetFields];
}

@end
