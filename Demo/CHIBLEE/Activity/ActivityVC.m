//
//  ActivityVC.m
//  Chiblee
//
//  Created by Shailendra Pandey on 12/4/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import "ActivityVC.h"

#import "ActivityCell.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "defineAllURL.h"

#import "AnalyticsHelper.h"
#import "MBProgressHUD.h"
#import "SWRevealViewController.h"
#import "CAPSPageMenu.h"
#import "ReviewedVC.h"
#import "ContactedVC.h"

@interface ActivityVC ()
@property (nonatomic) CAPSPageMenu *pageMenu;
@end

@implementation ActivityVC

#pragma markViewControllerLifeCycle


- (void)viewDidLoad {
    [super viewDidLoad];
   


    
   _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.navigationItem.title=@"MY PROFILE";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;

    [self menusliderpage];

    
    
   
}
- (void)didReceiveMemoryWarning {
    
       [super didReceiveMemoryWarning];
}


-(void)menusliderpage{
  
 ContactedVC *controller1 = [self.storyboard instantiateViewControllerWithIdentifier:@
                           "ContactedVC"];
    controller1.parentNavigationController = self.navigationController;

controller1.title = @"CONTACTED";
    
    ReviewedVC *controller2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ReviewedVC"];
    controller2.parentNavigationController = self.navigationController;

controller2.title = @"REVIEWED";

    
    



NSArray *controllerArray = @[controller1, controller2,  ];
NSDictionary *parameters = @{
                             CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0],
                             CAPSPageMenuOptionViewBackgroundColor: [UIColor blackColor],
                             CAPSPageMenuOptionSelectionIndicatorColor: [UIColor redColor],
                             CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor clearColor],
                             CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:15.0],
                             CAPSPageMenuOptionMenuHeight: @(40.0),
                             CAPSPageMenuOptionMenuItemWidth: @(90.0),
                             CAPSPageMenuOptionCenterMenuItems: @(YES)
                             };

_pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
[self.view addSubview:_pageMenu.view];

}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



@end
