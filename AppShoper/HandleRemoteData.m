//
//  HandleRemoteData.m
//  MallMaps
//
//  Created by juan on 3/16/16.
//  Copyright (c) 2014 JUAN SOLER. All rights reserved.
//

#import "HandleRemoteData.h"

@interface HandleRemoteData ()
@property NSMutableData *responseData;
@end

@implementation HandleRemoteData

+(NSMutableDictionary *)requestData
{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"]];
    
    NSError *error;
    NSMutableDictionary *results;
    if(!data)
    {
        NSLog(@"Error al consultar informacion, verifique con el administrador ");
    }
    else
    {
        results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if(error)
        {
            NSLog(@"Error al consultar informacion %@",[error localizedDescription]);
        }
    }
    
    return results;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{}

/*
 
 Metodo que dada una url descarga la imagen para ser usada internamente
 */
+(UIImage *)getImageFromURL:(NSString *)url
{
    UIImage *imagen;
    NSURL *fullURL = [NSURL URLWithString:url];
    
    NSData *data=[NSData dataWithContentsOfURL:fullURL];
    
    imagen = [UIImage imageWithData:data];
    return imagen;
    
}

/*
 
 Metodo usado para almacenar localmente una imagen que se ha descargado, 
 y asi poder usarla en una posterior ocasion en caso de que no se puede establecer la 
 conexion a internet
 */
+(void)saveImage:(UIImage *)image withFileName:(NSString *)imageName
{
    NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]] options:NSAtomicWrite error:nil];
}

/*
 Dado un nombre de imagen carga la imagen que este guardada localmente que 
 corresponde con dicho nombre
 */
+(UIImage *)loadImage:(NSString *)imageName
{
    NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",directoryPath,imageName]];
    return image;
}
@end
