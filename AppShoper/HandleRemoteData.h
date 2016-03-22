//
//  HandleRemoteData.h
//  MallMaps
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2014 JUAN SOLER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HandleRemoteData : NSObject <NSURLConnectionDelegate>
+(NSMutableDictionary *)requestData;
+(UIImage *)getImageFromURL:(NSString *)url;
+(void)saveImage:(UIImage *)image withFileName:(NSString *)imageName;
+(UIImage *)loadImage:(NSString *)imageName;
@end
