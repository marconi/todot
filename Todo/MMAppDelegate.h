//
//  MMAppDelegate.h
//  Todo
//
//  Created by Marconi Moreto on 12/25/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMMainWindowController.h"

@interface MMAppDelegate : NSObject <NSApplicationDelegate>
{
    MMMainWindowController *_mainWindow;
}

@property (nonatomic, readonly) MMMainWindowController *mainWindow;

@end
