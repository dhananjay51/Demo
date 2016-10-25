//
//  SettingViewVC.m
//  CHIBLEE
//
//  Created by vikas on 1/30/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "SettingViewVC.h"
#import "AboutVC.h"
#import "PrivacyPolicyVC.h"
#import "Terms&Condition.h"
#import "AnalyticsHelper.h"
#import "SWRevealViewController.h"

@interface SettingViewVC ()
{
    
}
@end

@implementation SettingViewVC

#pragma mark
#pragma mark ViewControllerLifeCycle
#pragma mark


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chibleelogo.layer.cornerRadius = self.chibleelogo.frame.size.height/2;
    self.chibleelogo.clipsToBounds = YES;
     
    self.title=@"ABOUT";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
       
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    

}
-(void)viewWillAppear:(BOOL)animated{
    [AnalyticsHelper trackScreen:@"Setting Screen"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)termandcondition:(UIButton*)sender{
    AboutVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
    
    [ self.navigationController pushViewController: vc animated:YES];
}
-(IBAction)privacyandpolicy:(UIButton*)sender{
    
    PrivacyPolicyVC*vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyVC"];
    
    
    [ self.navigationController pushViewController: vc animated:YES];
}


@end
