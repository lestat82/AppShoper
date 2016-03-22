//
//  ViewController.h
//  AppShoper
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

@interface DetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) App *app;
@property (strong,nonatomic) NSManagedObjectContext *context;
@end

