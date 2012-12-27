//
//  MMDataController.h
//  Todo
//
//  Created by Marconi Moreto on 12/25/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface MMDataController : NSObject
{
    sqlite3 *connection;
}

- (void) initializeDatabase;

@end
