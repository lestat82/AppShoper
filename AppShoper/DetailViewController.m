//
//  ViewController.m
//  AppShoper
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *appSummary;
@property (weak, nonatomic) IBOutlet UIImageView *appDetailImage;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.appDetailImage.image = self.app.bigImage;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    //self.appDetailImage.frame = CGRectMake(20,72, 158, 105);
    self.appDetailImage.frame = CGRectMake(20,72, 15, 15);
    
    [UIView commitAnimations];
    self.title = self.app.name;
    self.appSummary.text = self.app.summary;
    
    
    // Do any additional setup after loading the view, typically from a nib.
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
    NSString *value;
    if (indexPath.row==1) {
        value  = [NSString stringWithFormat:@"Name: %@",self.app.name];
    }
    else     if (indexPath.row==2) {
        value  = [NSString stringWithFormat:@"Price: %@",self.app.price];
    }
    else     if (indexPath.row==3) {
        value  = [NSString stringWithFormat:@"Title: %@",self.app.title];
    }
    else     if (indexPath.row==4) {
        value  = [NSString stringWithFormat:@"Category: %@",self.app.category];
    }
    else     if (indexPath.row==5) {
        value  = [NSString stringWithFormat:@"Artist: %@",self.app.artist];
    }
    /*else     if (indexPath.row==6) {
        value  = [NSString stringWithFormat:@"Summary: %@",self.app.summary];
    }*/
    //cell.alpha = 0.2;
    //cell.textLabel.alpha = 1;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor clearColor];
    
    //cell.textLabel.font =
    cell.textLabel.text = value;
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
