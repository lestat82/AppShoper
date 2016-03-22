//
//  App.m
//  AppShoper
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2014 JUAN SOLER. All rights reserved.
//

#import "App.h"


@implementation App


-(instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier category:(NSString *)category price:(NSString *)price link:(NSURL *)link artist:(NSString *)artist title:(NSString *)title summary:(NSString *)summary releaseDate:(NSDate *)releaseDate smallImage:(UIImage *)smallImage mediumImage:(UIImage *)mediumImage bigImage:(UIImage *)bigImage
{
    self.name = name;
    self.identifier = identifier;
    self.category = category;
    self.price = price;
    self.link = link;
    self.artist = artist;
    self.title = title;
    self.summary = summary;
    self.releaseDate = releaseDate;
    self.smallImage = smallImage;
    self.mediumImage = mediumImage;
    self.bigImage = bigImage;
    return self;
}
@end
