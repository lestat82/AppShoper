//
//  CategoryViewController.m
//  AppShoper
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import "CategoryViewController.h"
#import "AppViewController.h"
#import "GridAppViewController.h"
#import "HandleRemoteData.h"
#import "App.h"
#import "AppEntity.h"
#import "AppEntity+local.h"

@interface CategoryViewController ()
@property (strong,nonatomic) NSMutableArray *categoryList;
@property (strong,nonatomic) NSMutableArray *appList;
@property (strong,nonatomic) NSString *selectedCategory;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSString *documentName = @"AppShoper";
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [document openWithCompletionHandler:^(BOOL success) {
            if(!success)
            {
                NSLog(@"Error al abrir el documento");
            }
        }];
        _context = document.managedObjectContext;
    }
    else
    {
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if(!success)
            {
                NSLog(@"Error al crear el documento");
            }
        }];
        _context = document.managedObjectContext;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)appList
{
    if(!_appList)
    {
        _appList = [[NSMutableArray alloc] init];
    }
    return _appList;
}

-(NSMutableArray *)categoryList
{
    if(!_categoryList)
    {
        _categoryList = [[NSMutableArray alloc] init];
        NSMutableDictionary *results = [HandleRemoteData  requestData];
        App *app;
        NSString *name;
        NSString *identifier;
        NSString *description;
        NSString *price;
        NSString *category;
        NSString *artist;
        NSString *title;
        NSURL *url;
        NSDate *releaseDate;
        
        NSString *appImageName;
        UIImage *appSmallImage;
        UIImage *appMediumImage;
        UIImage *appBigImage;
        
        if(results)
        {
            NSMutableDictionary *returnedData = [results objectForKey:@"feed"];
            NSArray *returnedAppList = [returnedData objectForKey:@"entry"];
            NSArray *imageList;
            NSMutableDictionary *jsonName;
            NSMutableDictionary *jsonDescription;
            NSMutableDictionary *jsonImage;
            NSMutableDictionary *jsonPrice;
            NSMutableDictionary *jsonCategory;
            NSMutableDictionary *jsonURL;
            NSMutableDictionary *jsonArtist;
            NSMutableDictionary *jsonTitle;
            NSMutableDictionary *jsonReleaseDate;
            NSMutableDictionary *jsonIdentifier;
            
            NSNumberFormatter *nf = [[NSNumberFormatter alloc]init];
            nf.numberStyle = NSNumberFormatterDecimalStyle;
            
            for (NSMutableDictionary *returnedApp in returnedAppList) {
                jsonName = [returnedApp objectForKey:@"im:name"];
                jsonDescription = [returnedApp objectForKey:@"summary"];
                jsonPrice = [[returnedApp objectForKey:@"im:price"] objectForKey:@"attributes"];
                jsonCategory = [[returnedApp objectForKey:@"category"] objectForKey:@"attributes"];
                jsonURL = [[returnedApp objectForKey:@"link"] objectForKey:@"attributes"];
                jsonArtist = [returnedApp objectForKey:@"im:artist"];
                jsonTitle = [returnedApp objectForKey:@"title"];
                jsonIdentifier = [returnedApp objectForKey:@"id"];
                
                imageList = [returnedApp objectForKey:@"im:image"];
                jsonImage = imageList[0];
                
                name = [jsonName objectForKey:@"label"];
                description = [jsonDescription objectForKey:@"label"];
                price = [NSString stringWithFormat:@"%@ %@",[jsonPrice objectForKey:@"amount"],[jsonPrice objectForKey:@"currency"]];
                category = [jsonCategory objectForKey:@"label"];
                url = [NSURL URLWithString:[jsonURL objectForKey:@"href"]];
                artist = [jsonArtist objectForKey:@"label"];
                title = [jsonTitle objectForKey:@"label"];
                identifier = [[jsonIdentifier objectForKey:@"attributes"] objectForKey:@"im:id"];
                
                appImageName = [imageList[0] objectForKey:@"label"];
                appSmallImage =[HandleRemoteData getImageFromURL:appImageName];
                [HandleRemoteData saveImage:appSmallImage withFileName:[NSString stringWithFormat:@"small-%@",identifier]];
                
                appImageName = [imageList[1] objectForKey:@"label"];
                appMediumImage =[HandleRemoteData getImageFromURL:appImageName];
                [HandleRemoteData saveImage:appBigImage withFileName:[NSString stringWithFormat:@"medium-%@",identifier]];
                
                appImageName = [imageList[2] objectForKey:@"label"];
                appBigImage =[HandleRemoteData getImageFromURL:appImageName];
                [HandleRemoteData saveImage:appBigImage withFileName:[NSString stringWithFormat:@"big-%@",identifier]];
                
                app = [[App alloc] initWithName:name identifier:[nf numberFromString: identifier] category:category price:price link:url artist:artist title:title summary:description releaseDate:releaseDate smallImage:appSmallImage mediumImage:appMediumImage bigImage:appBigImage];
                
                [self addDifferent:_categoryList newValueForCheck:category];
                [self.appList addObject:app];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Error de conexion con el servidor, se cargara el listado almacenado localmente" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
            [alert show];
            
            NSArray *savedApps = [AppEntity listOfLocalApps:self.context];
            for (AppEntity *savedApp in savedApps) {
            
                name = savedApp.name;
                description = savedApp.summary;
                price = savedApp.price;
                category = savedApp.category;
                artist = savedApp.artist;
                title = savedApp.title;
                url = [NSURL URLWithString:savedApp.link];
        
                appSmallImage = [HandleRemoteData loadImage:[NSString stringWithFormat:@"small-%@",savedApp.identifier]];
                appMediumImage = [HandleRemoteData loadImage:[NSString stringWithFormat:@"medium-%@",savedApp.identifier]];
                appBigImage = [HandleRemoteData loadImage:[NSString stringWithFormat:@"big-%@",savedApp.identifier]];
                
                app = [[App alloc] initWithName:name identifier:savedApp.identifier category:category price:price link:url artist:artist title:title summary:description releaseDate:releaseDate smallImage:appSmallImage mediumImage:appMediumImage bigImage:appBigImage];
                
                
                [self.appList addObject:app];
                [self addDifferent:_categoryList newValueForCheck:category];
            }
            
        }
    }
    return _categoryList;
}

#pragma mark - Table Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryList" forIndexPath:indexPath];
    App *thisApp;
    //cell.alpha = 0.2;
    //cell.textLabel.alpha = 1;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor clearColor];
    thisApp = [self.appList objectAtIndex:indexPath.row];
    
    NSString *thisCategory = [self.categoryList objectAtIndex:indexPath.row];
    
    //cell.textLabel.font =
    cell.textLabel.text = thisCategory;
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCategory = [self.categoryList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"appList" sender:nil];
}

#pragma mark - Support

-(NSMutableArray *)addDifferent:(NSMutableArray *)originalArray newValueForCheck:(NSString *)value
{
    NSMutableArray *finalArray;
    finalArray = originalArray;
    BOOL found = false;
    for (int i=0;i<[originalArray count];i++) {
        if([value isEqualToString:[originalArray objectAtIndex:i]])
        {
            found = true;
        }
    }
    if (!found) {
        [finalArray addObject:value];
    }
    return finalArray;
}

-(NSMutableArray *)filterApps:(NSMutableArray *)appList forCategory:(NSString *)category
{
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    for (App *app in appList) {
        if ([app.category isEqualToString:category]) {
            [finalArray addObject:app];
        }
    }
    return finalArray;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[AppViewController class]]) {
        AppViewController *avc = (AppViewController   *)[segue destinationViewController];
        NSMutableArray *appsForCategory = [self filterApps:self.appList forCategory:self.selectedCategory];
        avc.appList = appsForCategory;
        avc.context = self.context;
    }
    else if ([[segue destinationViewController] isKindOfClass:[GridAppViewController class]]) {
        AppViewController *gvc = (AppViewController   *)[segue destinationViewController];
        NSMutableArray *appsForCategory = [self filterApps:self.appList forCategory:self.selectedCategory];
        gvc.appList = appsForCategory;
        gvc.context = self.context;
    }
}


@end
