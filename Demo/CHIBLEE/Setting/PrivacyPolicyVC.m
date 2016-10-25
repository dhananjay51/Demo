//
//  SettingVC.m
//  CHIBLEE
//
//  Created by Shailendra Pandey on 12/10/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import "PrivacyPolicyVC.h"
#import "AppDelegate.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKLoginKit/FBSDKLoginButton.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>


#import "MBProgressHUD.h"
#import <Google/Analytics.h>
#import "AnalyticsHelper.h"

@interface PrivacyPolicyVC ()

@end

@implementation PrivacyPolicyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Privacy&Policy";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
 //   NSString *urlAddress = @"http://Loudshout.com";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //Create a URL object.
    //NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
   /// NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    NSURL *htmlFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"privacy" ofType:@"html"]];
    [ detailWebView loadRequest:[NSURLRequest requestWithURL:htmlFile]];
    
    
    //Load the request in the UIWebView.
 //   [detailWebView loadRequest:requestObj];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [AnalyticsHelper trackScreen:@"privacy policy Screen"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
