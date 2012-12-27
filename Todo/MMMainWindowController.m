//
//  MMMainWindowController.m
//  Todo
//
//  Created by Marconi Moreto on 12/26/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import "MMMainWindowController.h"
#import "MMAddTodo.h"
#import "MMTodo.h"
#import "MMTodoInfo.h"

#define MAIN_WINDOW_HEIGHT 348.0f
#define MAIN_WINDOW_WIDTH 260.0f
#define STATUSBAR_HEIGHT 32.0f

#define ADD_TODOVIEW_HEIGHT 290.0f

#define SLIDING_SPEED 0.3
#define PARALLEL_VIEWS_GUTTER 5.0f  // space between parallel views
#define PARALLEL_VIEWS_WIDTH (MAIN_WINDOW_WIDTH * 2) + PARALLEL_VIEWS_GUTTER


@implementation MMMainWindowController

@synthesize todoListScrollView = _todoListScrollView,
            deleteButton = _deleteButton,
            addTodoView = _addTodoView,
            todoTable = _todoTable,
            todoList = _todoList,
            selectedRow = _selectedRow,
            todoInfoView = _todoInfoView,
            totalLabel = _totalLabel;

- (id) initWithWindowNibName:(NSString *)windowNibName
{
    self = [super initWithWindowNibName:windowNibName];
    if (self)
    {
        [self setSelectedRow:-1];
        [self setTodoList:[[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
}

- (void) dealloc
{
    [[self todoList] release];
    [self setTodoList:nil];

    [super dealloc];
}

- (void) awakeFromNib
{
    [[self deleteButton] setEnabled:NO];
}

#pragma mark -
#pragma mark ADD TODO FORM ACTIONS
#pragma -----------------------------------------------------------------------------------------------------------------------

- (IBAction) showAddContactForm:(id)sender
{
    [[self addTodoView] setIsShown: YES];

    // position add todo form view below main window
    [[self addTodoView] setFrame:CGRectMake(0.0, -MAIN_WINDOW_HEIGHT, MAIN_WINDOW_WIDTH, ADD_TODOVIEW_HEIGHT)];
    
    NSMutableDictionary *todoListScrollViewAnimDict = [NSMutableDictionary dictionaryWithCapacity:3];
    NSMutableDictionary *addTodoAnimDict = [NSMutableDictionary dictionaryWithCapacity:3];
    
    {  // animation dict for resizing todolist scroll view
        NSRect startPosition = [[self todoListScrollView] frame];
        NSRect endPosition = [[self todoListScrollView] frame];
        endPosition.origin.y = ADD_TODOVIEW_HEIGHT;
        endPosition.size.height = (MAIN_WINDOW_HEIGHT - ADD_TODOVIEW_HEIGHT) + STATUSBAR_HEIGHT;
        
        [todoListScrollViewAnimDict setObject:[self todoListScrollView] forKey:NSViewAnimationTargetKey];
        [todoListScrollViewAnimDict setObject:[NSValue valueWithRect:startPosition] forKey:NSViewAnimationStartFrameKey];
        [todoListScrollViewAnimDict setObject:[NSValue valueWithRect:endPosition] forKey:NSViewAnimationEndFrameKey];
    }
    
    {  // animation dict for sliding-in add todo form
        NSRect startPosition = [[self addTodoView] frame];
        NSRect endPosition = [[self addTodoView] frame];
        endPosition.origin.y = 0;

        [addTodoAnimDict setObject:[self addTodoView] forKey:NSViewAnimationTargetKey];
        [addTodoAnimDict setObject:[NSValue valueWithRect:startPosition] forKey:NSViewAnimationStartFrameKey];
        [addTodoAnimDict setObject:[NSValue valueWithRect:endPosition] forKey:NSViewAnimationEndFrameKey];
    }
    
    NSViewAnimation *anim = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObjects:todoListScrollViewAnimDict, addTodoAnimDict, nil]];
    [anim setDuration:SLIDING_SPEED];
    [anim setAnimationCurve:NSAnimationEaseIn];

    [[[self window] contentView] addSubview:[self addTodoView]];
    
    [anim startAnimation];
    [anim release];
    anim = nil;
}

- (IBAction) showTodoInfo:(id)sender
{
    // if the add todo form is shown, hide it first
    if ([[self addTodoView] isShown]) {
        [self hideAddTodoForm];
    }
    
    [[self todoInfoView] showTodoInfo:[self todoOnSelectedRow] atIndex:[[self todoTable] selectedRow]];

    // don't proceed with animation if todo info view is already shown
    if ([[self todoInfoView] isShown]) {
        return;
    }

    // position todo info view side by side with table scroll view
    NSRect todoInfoViewPosition = [[self todoInfoView] frame];
    todoInfoViewPosition.origin.x = MAIN_WINDOW_WIDTH + PARALLEL_VIEWS_GUTTER;
    todoInfoViewPosition.origin.y = STATUSBAR_HEIGHT;
    [[self todoInfoView] setFrame:todoInfoViewPosition];
    [[self todoInfoView] setIsShown:YES];

    NSMutableDictionary *windowViewAnimDict = [NSMutableDictionary dictionaryWithCapacity:3];

    {
        NSRect startPosition = [[self window] frame];
        NSRect endPosition = [[self window] frame];
        endPosition.size.width = PARALLEL_VIEWS_WIDTH;
        
        [windowViewAnimDict setObject:[self window] forKey:NSViewAnimationTargetKey];
        [windowViewAnimDict setObject:[NSValue valueWithRect:startPosition] forKey:NSViewAnimationStartFrameKey];
        [windowViewAnimDict setObject:[NSValue valueWithRect:endPosition] forKey:NSViewAnimationEndFrameKey];
    }
    
    NSViewAnimation *anim = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObject:windowViewAnimDict]];
    [anim setDuration:SLIDING_SPEED];
    [anim setAnimationCurve:NSAnimationEaseIn];
    
    [[[self window] contentView] addSubview:[self todoInfoView]];

    [anim startAnimation];
    [anim release];
    anim = nil;
}

- (void) closeTodoInfo
{
    [[self todoInfoView] setIsShown:NO];
    
    NSMutableDictionary *windowViewAnimDict = [NSMutableDictionary dictionaryWithCapacity:3];
    
    {
        NSRect startPosition = [[self window] frame];
        NSRect endPosition = [[self window] frame];
        endPosition.size.width = MAIN_WINDOW_WIDTH;
        
        [windowViewAnimDict setObject:[self window] forKey:NSViewAnimationTargetKey];
        [windowViewAnimDict setObject:[NSValue valueWithRect:startPosition] forKey:NSViewAnimationStartFrameKey];
        [windowViewAnimDict setObject:[NSValue valueWithRect:endPosition] forKey:NSViewAnimationEndFrameKey];
    }
    
    NSViewAnimation *anim = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObject:windowViewAnimDict]];
    [anim setDuration:SLIDING_SPEED];
    [anim setAnimationCurve:NSAnimationEaseIn];
    
    [self performSelector:@selector(removeViewFromSuperView:) withObject:[self todoInfoView] afterDelay:[[NSAnimationContext currentContext] duration]];
    
    [anim startAnimation];
    [anim release];
    anim = nil;
}

- (void) hideAddTodoForm
{
    [[self addTodoView] setIsShown: NO];
    NSMutableDictionary *todoListScrollViewAnimDict = [NSMutableDictionary dictionaryWithCapacity:3];
    NSMutableDictionary *addTodoAnimDict = [NSMutableDictionary dictionaryWithCapacity:3];

    {  // animation dict for resizing todolist scroll view
        NSRect startPosition = [[self todoListScrollView] frame];
        NSRect endPosition = [[self todoListScrollView] frame];
        endPosition.origin.y = STATUSBAR_HEIGHT;
        endPosition.size.height = MAIN_WINDOW_HEIGHT;
        
        [todoListScrollViewAnimDict setObject:[self todoListScrollView] forKey:NSViewAnimationTargetKey];
        [todoListScrollViewAnimDict setObject:[NSValue valueWithRect:startPosition] forKey:NSViewAnimationStartFrameKey];
        [todoListScrollViewAnimDict setObject:[NSValue valueWithRect:endPosition] forKey:NSViewAnimationEndFrameKey];
    }
    
    {  // animation dict for sliding-out add todo form
        NSRect startPosition = [[self addTodoView] frame];
        NSRect endPosition = [[self addTodoView] frame];
        endPosition.origin.y = -ADD_TODOVIEW_HEIGHT;
        
        [addTodoAnimDict setObject:[self addTodoView] forKey:NSViewAnimationTargetKey];
        [addTodoAnimDict setObject:[NSValue valueWithRect:startPosition] forKey:NSViewAnimationStartFrameKey];
        [addTodoAnimDict setObject:[NSValue valueWithRect:endPosition] forKey:NSViewAnimationEndFrameKey];
    }

    NSViewAnimation *anim = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObjects:todoListScrollViewAnimDict, addTodoAnimDict, nil]];
    [anim setDuration:SLIDING_SPEED];
    [anim setAnimationCurve:NSAnimationEaseIn];

    [self performSelector:@selector(removeViewFromSuperView:) withObject:[self addTodoView] afterDelay:[[NSAnimationContext currentContext] duration]];
    
    [anim startAnimation];
    [anim release];
    anim = nil;
}

- (void) removeViewFromSuperView:(NSView *)view
{
    [view removeFromSuperview];
}

- (void) addTodo:(MMTodo *)newTodo
{
    [[self todoList] addObject:newTodo];
    [[self todoTable] noteNumberOfRowsChanged];
}

- (void) updateTodo:(MMTodo *)todo atIndex:(NSInteger)rowIndex;
{
    [[self todoList] setObject:todo atIndexedSubscript:rowIndex];
    
    [[self todoTable] reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:rowIndex] columnIndexes:[NSIndexSet indexSetWithIndex:0]];
    
    NSTableCellView *row = [[self todoTable] viewAtColumn:0 row:rowIndex makeIfNecessary:NO];
    [[row textField] setTextColor:[NSColor grayColor]];
}

- (MMTodo *) todoOnSelectedRow
{
    MMTodo *todo = [[self todoList] objectAtIndex:[[self todoTable] selectedRow]];
    return todo;
}

- (IBAction) deleteTodo:(id)sender
{
    NSInteger rowIndex = [[self todoTable] selectedRow];
    [[self todoList] removeObjectAtIndex:rowIndex];
    [[self todoTable] reloadData];  // FIXME: this is lazy!
}

#pragma mark -
#pragma mark TABLEVIEW DATASOURCE & DELEGATE
#pragma -----------------------------------------------------------------------------------------------------------------------

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
    NSUInteger rowsCount = [[self todoList] count];
    NSString *label = [[[NSString alloc] initWithFormat:@"Total items: %li", rowsCount] autorelease];
    [[self totalLabel] setStringValue:label];
    return rowsCount;
}

- (NSView *) tableView:(NSTableView *)tableView
    viewForTableColumn:(NSTableColumn *)tableColumn
                   row:(NSInteger)row
{
    MMTodo *todo = [[self todoList] objectAtIndex:row];
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:[tableColumn identifier] owner:self];
    cellView.textField.stringValue = [[[NSString alloc] initWithFormat:@"%@", [todo name]] autorelease];
    return cellView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{   
    // if there's a previously selected row, hide its image.
    if ([self selectedRow] != -1) {
        NSTableCellView *row = [[self todoTable] viewAtColumn:0 row:[self selectedRow] makeIfNecessary:NO];
        [[[row subviews] objectAtIndex:1] setHidden:YES];
    }
    
    // enable delete button
    [[self deleteButton] setEnabled:YES];
    
    NSInteger rowIndex = [[self todoTable] selectedRow];
    NSTableCellView *row = [[self todoTable] viewAtColumn:0 row:rowIndex makeIfNecessary:NO];
    [[[row subviews] objectAtIndex:1] setHidden:NO];
    
    // set our new selected row
    [self setSelectedRow:rowIndex];
    
    // if the todo info is shown, show the currently selected row's todo
    if ([[self todoInfoView] isShown]) {
        [[self todoInfoView] showTodoInfo:[self todoOnSelectedRow] atIndex:[[self todoTable] selectedRow]];
    }
}

@end
