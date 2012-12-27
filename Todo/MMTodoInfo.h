//
//  MMTodoInfo.h
//  Todo
//
//  Created by Marconi Moreto on 12/27/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMTodo.h"

@interface MMTodoInfo : NSView
{
    IBOutlet NSTextField *_name;
    IBOutlet NSTextField *_description;
    IBOutlet NSButton    *_isDone;
    IBOutlet id          delegate;
             BOOL        _isShown;
    
             NSInteger   _rowIndex;
             MMTodo      *_todo;
}

- (IBAction) closeButtonPressed:(id)sender;
- (IBAction) updateTodo:(id)sender;

- (void) resetFields;
- (void) showTodoInfo:(MMTodo *)todo atIndex:(NSInteger) rowIndex;

@property (nonatomic, readonly) NSTextField *name;
@property (nonatomic, readonly) NSTextField *description;
@property (nonatomic, readonly)    NSButton *isDone;
@property (nonatomic, assign)          BOOL isShown;

@property (nonatomic, assign)     NSInteger rowIndex;
@property (nonatomic, retain)        MMTodo *todo;

@end
