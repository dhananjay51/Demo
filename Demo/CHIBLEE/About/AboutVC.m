//
//  AboutVC.m
//  CHIBLEE
//
//  Created by Shailendra Pandey on 12/10/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import "AboutVC.h"

#import "AnalyticsHelper.h"
#import "MBProgressHUD.h"

@interface AboutVC ()
{
    IBOutlet UIWebView*detailWebView;
}

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"About";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    NSString *urlAddress = @"http://www.chiblee.com/#about";
  //  detailWebView.scalesPageToFit = YES;
  //  detailWebView.contentMode = UIViewContentModeScaleAspectFit;
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    [MBProgressHUD showHUDAddedTo :self.view animated:YES];
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [detailWebView loadRequest:requestObj];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [AnalyticsHelper trackScreen:@"SearchScreen"];
}


@end
