//
//  CategoryViewController.h
//  AppShoper
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray *appList;
@property (strong,nonatomic) NSManagedObjectContext *context;
@end
