//
//  MMTodoInfo.m
//  Todo
//
//  Created by Marconi Moreto on 12/27/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import "MMTodoInfo.h"
#import "MMMainWindowController.h"
#import "MMTodo.h"

@implementation MMTodoInfo

@synthesize name = _name,
            description = _description,
            isDone = _isDone,
            isShown = _isShown,
            todo = _todo,
            rowIndex = _rowIndex;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setIsShown:NO];
        [self setRowIndex:-1];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void) showTodoInfo:(MMTodo *)todo atIndex:(NSInteger) rowIndex;
{
//    [todo retain];
    [self setRowIndex:rowIndex];
    [self setTodo:todo];
    [[self name] setStringValue:[todo name]];
    [[self description] setStringValue:[todo description]];
    [[self isDone] setState:([todo isDone]) ? YES : NO];
}

#pragma mark -
#pragma mark TODO INFO FORM ACTIONS
#pragma -----------------------------------------------------------------------------------------------------------------------

- (void) resetFields
{
    [[self name] setStringValue:@""];
    [[self description] setStringValue:@""];
}

- (IBAction) closeButtonPressed:(id)sender
{
    if ([delegate respondsToSelector:@selector(closeTodoInfo)]) {
        [delegate closeTodoInfo];
    }
    [self resetFields];
}

- (IBAction) updateTodo:(id)sender
{
    [[self todo] setName:[[self name] stringValue]];
    [[self todo] setDescription:[[self description] stringValue]];
    [[self todo] setIsDone:([[self isDone] state]) ? YES : NO];
    
    if ([delegate respondsToSelector:@selector(updateTodo:atIndex:)]) {
        [delegate updateTodo:[self todo] atIndex:[self rowIndex]];
    }
}

@end
