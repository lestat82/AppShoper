//
//  GridAppViewController.m
//  AppShoper
//
//  Created by juan on 3/21/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import "GridAppViewController.h"
#import "CustomGridCell.h"
#import "DetailViewController.h"
#import "App.h"
#import <QuartzCore/QuartzCore.h>

@interface GridAppViewController ()
@property (nonatomic) App *selectedApp;
@end

@implementation GridAppViewController

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

#pragma mark - CollectionView Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.appList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"appItem" forIndexPath:indexPath];
    App *myApp = (App *)[self.appList objectAtIndex:indexPath.item];
    cell.appImage.image = myApp.mediumImage;
    cell.appName.text = myApp.name;
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedApp = (App *)[self.appList objectAtIndex:indexPath.item];
    [self performSegueWithIdentifier:@"appDetail" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[DetailViewController class]]) {
        DetailViewController *dvc = (DetailViewController   *)[segue destinationViewController];
        dvc.app = self.selectedApp;
        dvc.context = self.context;
}
}

@end
