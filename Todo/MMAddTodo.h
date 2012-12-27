//
//  MMAddContact.h
//  Todo
//
//  Created by Marconi Moreto on 12/26/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MMAddTodo : NSView
{
    IBOutlet NSTextField *_name;
    IBOutlet NSTextField *_description;
    IBOutlet NSTextField *_nameLabel;
    IBOutlet NSTextField *_descriptionLabel;
    IBOutlet NSTextField *_formTitle;
    IBOutlet id          delegate;
             BOOL        _isShown;
}

- (IBAction) okButtonPressed:(id)sender;
- (IBAction) cancelButtonPressed:(id)sender;

- (void) resetFields;

@property (nonatomic, readonly) IBOutlet NSTextField *name;
@property (nonatomic, readonly) IBOutlet NSTextField *description;
@property (nonatomic, assign)            BOOL isShown;

@end
