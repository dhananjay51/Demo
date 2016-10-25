
//
//  ServiceHIt.m
//  project
//
//  Created by Abhishek Srivastava on 22/10/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import "ServiceHIt.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@implementation ServiceHIt
NSMutableURLRequest *theRequest;
NSURLSession *session;

+(id)sharedInstances
{
    static ServiceHIt *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
-(void)headerMethod:(NSDictionary *)userDic serverUrl:(NSString *)userUrl
{
    
    
    NSString *encodedUrl = [userUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *baseURL = [NSURL URLWithString:encodedUrl];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenid= [defaults objectForKey:@"fbid"];
    
    
    if ([[AppDelegate getDelegate] connected]) {
        
        theRequest = [NSMutableURLRequest requestWithURL:baseURL];
        [theRequest addValue:tokenid forHTTPHeaderField:@"Authorization"];
        
        [theRequest setHTTPMethod:@"GET"];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"No Internet connection"];
    }
    
}

-(void)commonMethod:(NSDictionary *)dictValues andserverURL:(NSString *)url success:(void (^)(NSDictionary *dict))success fail:(ErrorHandler)failure
{
    [self headerMethod:dictValues serverUrl:url];
    
    configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    configuration.timeoutIntervalForRequest = 60.0;
    session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    postDataTask = [session dataTaskWithRequest:theRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                    {
                        if(error == nil)
                        {
                            NSDictionary *result=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                            if (result)
                            {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    success(result);
                                });
                            }
                            else
                            {// dhananjay singh
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    failure(error);
                                });
                            }
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                failure(error);
                            });
                        }
                    }];
    [postDataTask resume];
}
///////////////////local data/////////////////////////////////////
-(void)PostheaderMethod:(NSString* )poststringheader serverUrl:(NSString *)userUrl{
    
    NSString *encodedUrl = [userUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *baseURL = [NSURL URLWithString:encodedUrl];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenid= [defaults objectForKey:@"fbid"];
    
    
    if ([[AppDelegate getDelegate] connected]) {
        
        theRequest = [NSMutableURLRequest requestWithURL: baseURL];
        //[theRequest addValue: tokenid forHTTPHeaderField:@"Authorization"];
        
        
        
        [theRequest setHTTPMethod:@"POST"];
        
        NSString *postString = poststringheader;
        [theRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"No Internet connection"];    }
    
}
-(void)PostMethod:(NSString* )poststring andserverURL:(NSString* )url success:(void (^)(id dict))success fail:(ErrorHandler)failure{
    
    [self  PostheaderMethod:poststring serverUrl:url];
    
    configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    configuration.timeoutIntervalForRequest = 60.0;
    session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    postDataTask = [session dataTaskWithRequest:theRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                    {
                        if(error == nil)
                        {
                            ;
                            
                            NSDictionary *result=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                            if (result)
                            {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    success(result);
                                });
                            }
                            else
                            {// dhananjay singh
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    failure(error);
                                });
                            }
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                failure(error);
                            });
                        }
                    }];
    [postDataTask resume];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
    SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, 0);
    NSData *remoteCertificateData = CFBridgingRelease(SecCertificateCopyData(certificate));
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"SSL" ofType:@"cer"];
    NSData *localCertData = [NSData dataWithContentsOfFile:cerPath];
    
    if ([remoteCertificateData isEqualToData:localCertData])
    {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:serverTrust];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
    else
    {
        // [[challenge sender] cancelAuthenticationChallenge:challenge];
        // completionHandler(NSURLSessionAuthChallengeRejectProtectionSpace, nil);
    }
}


    @end

