//
//  MMAppDelegate.m
//  Todo
//
//  Created by Marconi Moreto on 12/25/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import "MMAppDelegate.h"
#import "MMDataController.h"

@implementation MMAppDelegate

@synthesize mainWindow = _mainWindow;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // initialize database
//    MMDataController *dataController = [[MMDataController alloc] init];
//
//    [dataController initializeDatabase];
//    
//    [dataController release];
//    dataController = nil;

    
    // show main window
    _mainWindow = [[MMMainWindowController alloc] initWithWindowNibName:@"MainWindow"];
    [[_mainWindow window] makeFirstResponder:nil];
    [_mainWindow showWindow:self];
}

@end
