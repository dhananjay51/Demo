//
//  Serverhit.m
//  AfNetworkingDemo
//
//  Created by Abhishek Srivastava on 26/03/16.
//  Copyright © 2016 LoudShout. All rights reserved.
//

#import "Serverhit.h"

#import <AFNetworking/AFHTTPSessionManager.h>



@implementation Serverhit

-(void)Serverhit:(NSString *)Url :(myCompletion)compblock
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[ NSURL URLWithString:  Url]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [ manager. requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * auth=[ prefs valueForKey:@"Auth"];
    [ manager. requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    

    
    
    [manager GET: Url parameters:  nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
         dispatch_async(dispatch_get_main_queue(), ^{
            compblock(responseObject);
        });
        
    }
          failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSMutableDictionary *dictError=[[NSMutableDictionary alloc]init];
         [dictError setValue:error.description forKey:@"ServiceError"];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             compblock( dictError);
         });
         
     }];
}
         


-(void)ServiceHitWithHttpString :( NSDictionary *)Dict :(NSString *)url :(myCompletion) compblock;
{
    
   
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[ NSURL URLWithString: url]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [ manager. requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * auth=[ prefs valueForKey:@"Auth"];
    [ manager. requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];

       [manager POST: url parameters:  Dict progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            compblock(responseObject);
        });
        
    }
          failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSMutableDictionary *dictError=[[NSMutableDictionary alloc]init];
         [dictError setValue:error.description forKey:@"ServiceError"];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             compblock( dictError);
         });
         
     }];

}



@end
