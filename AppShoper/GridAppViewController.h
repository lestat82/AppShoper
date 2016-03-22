//
//  GridAppViewController.h
//  AppShoper
//
//  Created by juan on 3/21/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridAppViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong,nonatomic) NSMutableArray *appList;
@property (strong,nonatomic) NSManagedObjectContext *context;
@end
