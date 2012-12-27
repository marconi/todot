//
//  MMMainWindowController.h
//  Todo
//
//  Created by Marconi Moreto on 12/26/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMAddTodo.h"
#import "MMTodo.h"
#import "MMTodoInfo.h"

@interface MMMainWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate>
{
    IBOutlet NSScrollView   *_todoListScrollView;
    IBOutlet NSButton       *_deleteButton;

    IBOutlet MMAddTodo      *_addTodoView;
    IBOutlet NSTableView    *_todoTable;
    IBOutlet NSTextField    *_totalLabel;
             NSInteger      _selectedRow;

    IBOutlet MMTodoInfo     *_todoInfoView;
    
             NSMutableArray *_todoList;
}

- (IBAction) showAddContactForm:(id)sender;
- (IBAction) showTodoInfo:(id)sender;
- (IBAction) deleteTodo:(id)sender;

- (void) hideAddTodoForm;
- (void) addTodo:(MMTodo *)newTodo;
- (void) closeTodoInfo;
- (void) removeViewFromSuperView:(NSView *)view;
- (void) updateTodo:(MMTodo *)todo atIndex:(NSInteger)rowIndex;
- (MMTodo *) todoOnSelectedRow;

@property (nonatomic, readonly) IBOutlet NSScrollView *todoListScrollView;
@property (nonatomic, readonly) IBOutlet NSButton *deleteButton;

@property (nonatomic, readonly) IBOutlet MMAddTodo   *addTodoView;
@property (nonatomic, readonly) IBOutlet NSTableView *todoTable;
@property (nonatomic, readonly) IBOutlet NSTextField *totalLabel;
@property (nonatomic, assign)            NSInteger   selectedRow;

@property (nonatomic, readonly) IBOutlet MMTodoInfo  *todoInfoView;

@property (nonatomic, retain)   IBOutlet NSMutableArray *todoList;

@end
