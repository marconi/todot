//
//  MMTodo.h
//  Todo
//
//  Created by Marconi Moreto on 12/26/12.
//  Copyright (c) 2012 Marconi Moreto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTodo : NSObject
{
    NSString *_name;
    NSString *_description;
    BOOL     _isDone;
}

- (id) initWithName:(NSString *)name andDescription:(NSString *)description;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) BOOL   isDone;

@end
