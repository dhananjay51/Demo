//
//  ServiceHIt.h
//  project
//
//  Created by Abhishek Srivastava on 22/10/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessHandler)(id responseObject);
typedef void (^ErrorHandler)(NSError *error);

@interface ServiceHIt : NSObject <NSURLSessionDelegate, NSURLConnectionDelegate>
{
    NSURLSessionConfiguration *configuration;
    NSURLSessionDataTask *postDataTask;
    NSURLSession *session;
}

+(id)sharedInstances;
-(void)headerMethod:(NSDictionary *)userDic serverUrl:(NSString *)userUrl;
-(void)commonMethod:(NSDictionary *)dictValues andserverURL:(NSString *)url success:(void (^)(NSDictionary *dict))success fail:(ErrorHandler)failure;
-(void)PostMethod:( NSString *)poststring andserverURL:(NSString *)url success:(void (^)(id dict))success fail:(ErrorHandler)failure;
-(void)PostheaderMethod:(NSString *)poststringheader serverUrl:(NSString *)userUrl;




@end
