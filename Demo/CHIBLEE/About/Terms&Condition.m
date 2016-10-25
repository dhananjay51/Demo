//
//  Terms&Condition.m
//  CHIBLEE
//
//  Created by vikas on 2/3/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "Terms&Condition.h"
#import "MBProgressHUD.h"
@interface Terms_Condition ()
{
     IBOutlet UIWebView*detailWebView;
}
@end

@implementation Terms_Condition

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Terms&Condition";
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:14.0/255.0 green:106.0/255.0 blue:63.0/255.0 alpha:1];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:14.0/255.0 green:106.0/255.0 blue:63.0/255.0 alpha:1]
                              }];
    self.navigationController.navigationBar.translucent = NO;
    NSString *urlAddress = @"http://Loudshout.com";
    
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
    
    
 //   [AnalyticsHelper trackScreen:@"SearchScreen"];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
