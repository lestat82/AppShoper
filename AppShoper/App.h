//
//  App.h
//  AppShoper
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2014 JUAN SOLER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface App : NSObject
@property (strong,nonatomic) NSNumber *identifier;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *category;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSURL *link;
@property (strong,nonatomic) NSString *artist;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *summary;
@property (strong,nonatomic) NSDate *releaseDate;
@property (strong,nonatomic) UIImage *smallImage;
@property (strong,nonatomic) UIImage *mediumImage;
@property (strong,nonatomic) UIImage *bigImage;

-(instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier category:(NSString *)category price:(NSString *)price link:(NSURL *)link artist:(NSString *)artist title:(NSString *)title summary:(NSString *)summary releaseDate:(NSDate *)releaseDate smallImage:(UIImage *)smallImage mediumImage:(UIImage *)mediumImage bigImage:(UIImage *)bigImage;

@end
