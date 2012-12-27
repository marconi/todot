//
//  MMTodo.m
//  Todo
//
//  Created by Marconi Moreto on 12/26/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import "MMTodo.h"

@implementation MMTodo

@synthesize name = _name,
            description = _description,
            isDone = _isDone;

- (id) initWithName:(NSString *)name andDescription:(NSString *)description
{
    self = [self init];
    if (self)
    {
        [self setIsDone:NO];
        [self setName:[[NSString alloc] initWithString:name]];
        [self setDescription:[[NSString alloc] initWithString:description]];
    }
    return self;
}

- (void) dealloc
{
    [[self name] release];
    [self setName:nil];
    
    [[self description] release];
    [self setDescription:nil];
    
    [super dealloc];
}

@end
