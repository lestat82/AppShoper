//
//  AppEntity+local.h
//  AppShoper
//
//  Created by juan on 3/19/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import "AppEntity.h"
#import "App.h"

@interface AppEntity (local)
+(AppEntity *)saveApp:(App *)app inManagedObjectContext:(NSManagedObjectContext *)context;
+(NSArray *)listOfLocalApps:(NSManagedObjectContext *)context;
@end
