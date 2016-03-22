//
//  CategoryViewController.m
//  AppShoper
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import "AppViewController.h"
#import "DetailViewController.h"
#import "HandleRemoteData.h"
#import "App.h"

@interface AppViewController ()
@property (nonatomic) App *selectedApp;
@end

@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    App *myApp = (App *)[self.appList firstObject];
    self.title = myApp.category;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    App *thisApp;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appList" forIndexPath:indexPath];
    //cell.alpha = 0.2;
    //cell.textLabel.alpha = 1;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor clearColor];
    thisApp = [self.appList objectAtIndex:indexPath.row];
    
    //cell.textLabel.font =
    cell.textLabel.text = thisApp.name;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.imageView.bounds = CGRectMake(0.0, 0.0, 50.0, 50.0);
    cell.imageView.image = thisApp.smallImage;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedApp = (App *)[self.appList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"appDetail" sender:nil];    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[DetailViewController class]]) {
        DetailViewController *dvc = (DetailViewController   *)[segue destinationViewController];
        dvc.app = self.selectedApp;
        dvc.context = self.context;
        
    }
}


@end
