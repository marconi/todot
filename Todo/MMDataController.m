//
//  MMDataController.m
//  Todo
//
//  Created by Marconi Moreto on 12/25/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import "MMDataController.h"

@implementation MMDataController

- (void) dealloc
{
    sqlite3_close(connection);
    [super dealloc];
}

- (void) initializeDatabase
{
    NSString *desktopPath = [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [desktopPath stringByAppendingPathComponent:@"todo.sqlite"];

    BOOL dbExists = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
    
    if (!dbExists) {
        if (sqlite3_open([dbPath UTF8String], &connection) == SQLITE_OK) {
            char *sql = "CREATE TABLE IF NOT EXISTS contact(id INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, NUMBER TEXT)";
            char *error = nil;
            if (sqlite3_exec(connection, sql, NULL, NULL, &error) == SQLITE_OK) {
                NSLog(@"Database and table created!");
            }
            else {
                NSLog(@"Error: %s", error);
            }
        }
    }
    else {
        NSLog(@"Database and tables already exists.");
    }
}

@end
