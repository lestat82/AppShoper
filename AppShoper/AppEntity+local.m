//
//  AppEntity+local.m
//  AppShoper
//
//  Created by juan on 3/19/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import "AppEntity+local.h"


@implementation AppEntity (local)

+(AppEntity *)saveApp:(App *)app inManagedObjectContext:(NSManagedObjectContext *)context
{
    AppEntity *myApp;
    
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"AppEntity"];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier==%d",[app.identifier longValue]];
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches||error||[matches count]>1)
    {
        myApp = [matches firstObject];
    }
    else if([matches count])
    {
        myApp = [matches firstObject];
    }
    else
    {
        myApp = [NSEntityDescription insertNewObjectForEntityForName:@"AppEntity" inManagedObjectContext:context];
        myApp.identifier = [NSNumber numberWithLong:[app.identifier longValue]];
        myApp.name = app.name;
        myApp.category = app.category;
        myApp.price = app.price;
        myApp.link = [app.link absoluteString];
        myApp.artist =  app.artist;
        myApp.title = app.title;
        myApp.summary = app.summary;
        myApp.releaseDate = app.releaseDate;
        
    }
    [self forceSave:context];
    return myApp;
}

+(NSArray *)listOfLocalApps:(NSManagedObjectContext *)context
{
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"AppEntity"];
    request.predicate = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches||error)
    {
        NSLog(@"Error al consultar entidad %@",[error localizedDescription]);
    }
    else
    {
        return matches;
    }
    return nil;
}

+(void)forceSave:(NSManagedObjectContext *)context {
    if (!context) {
        NSLog(@"NO CONTEXT!");
        return;
    }
    
    NSError * error;
    BOOL success = [context save:&error];
    if (error || !success) {
        NSLog(@"success: %@ - error: %@", success ? @"true" : @"false", error);
    }
    
    [context performSelectorOnMainThread:@selector(save:) withObject:nil waitUntilDone:YES];
    [context performSelector:@selector(save:) withObject:nil afterDelay:1.0];
    [context setStalenessInterval:6.0];
    while (context) {
        [context performBlock:^(){
            NSError * error;
            bool success =  [context save:&error];
            if (error || !success)
                NSLog(@"success: %@ - error: %@", success ? @"true" : @"false", error);
            
        }];
        context = context.parentContext;
    }
    
}

@end
