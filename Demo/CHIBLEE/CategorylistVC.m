//
//  ViewController.m
//  CHIBLEE
//
//  Created by Shailendra Pandey on 12/5/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//


#import "CategorylistVC.h"
#import "SearchListVC.h"

#import "MPCoachMarks.h"

#import "fontello.h"
#import "ServiceHIt.h"
#import "UIColor+Hex.h"

#import "AppDelegate.h"
#import <Reachability/Reachability.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "defineAllURL.h"
#import "SearchListVC.h"
#import <Crashlytics/Crashlytics.h>
#import "AnalyticsHelper.h"
#import "MBProgressHUD.h"

#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import <AppsFlyerTracker.h>
#import "DBManager.h"

#import "AppDelegate.h"
#import "EarnrewardVC.h"
#import "SWRevealViewController.h"
#import "SearchAreaVC.h"
#import "SubcategoryCell.h"
#import "SubcategoryVC.h"
#import "TLYShyNavBar.h"
#import "FAvvendorVC.h"
#import <Toast/UIView+Toast.h>
#import "defineAllURL.h"
#import "Serverhit.h"
#import "ViewController.h"

@import Firebase;



@interface CategorylistVC ()<searchDelegate>
{
    BOOL addvendor;
    NSArray * bannerArr;

}

@end

@implementation CategorylistVC
#pragma mark ViewControlllerLifeCycle


- (void)viewDidLoad {
      [super viewDidLoad];
    

    
   // self.shyNavBarManager.scrollView =self.scrollView1;
    
    pageControlBeingUsed = NO;
    addvendor=YES;
    
    
   
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        //its iPhone. Find out which one?
        
        CGSize resultszie = [[UIScreen mainScreen] bounds].size;
        if(resultszie.height == 480)
        {
            // iPhone Classic
        }
        else if(resultszie.height == 568)
        { self.scrollView1.contentSize = CGSizeMake(self.scrollView1.frame.size.width , self.scrollView.frame.size.height+530);
         
            // iPhone 5
        }
        else if(resultszie.height == 667)
        {
             self.scrollView1.contentSize = CGSizeMake(self.scrollView1.frame.size.width , self.scrollView.frame.size.height+560);
           
            // iPhone 6
        }
        else if(resultszie.height == 736)
        {
            self.scrollView1.contentSize = CGSizeMake(self.scrollView1.frame.size.width , self.scrollView.frame.size.height+650);
            // iPhone 6 Plus
        }
    }
  
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self fetchaddbanaer];
    
    
    
}

-(void)Addbanner{
   
    // NSArray *colors = [NSArray arrayWithObjects:[ UIImage imageNamed:@"banner.png"], [UIImage imageNamed:@"banner.png"], [ UIImage  imageNamed:@"banner.png"], nil];
    for (int i = 0; i < bannerArr.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        

        
        NSDictionary * imagedict=[ bannerArr objectAtIndex:i];
        NSString * image=[ imagedict valueForKey:@"imageUrl"];
        
        
      
        
        
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString: image] placeholderImage:[UIImage imageNamed:@"banner.png"]  ];
        
        /// subview.layer.cornerRadius =8;
        // subview.clipsToBounds = YES;

        
        imageView.contentMode =UIViewContentModeScaleAspectFit; //UIViewContentModeScaleToFill;
        // UIViewContentModeScaleAspectFit;
        
        //[colors objectAtIndex:i];
        imageView.layer.cornerRadius =8;
        imageView.clipsToBounds = YES;
       // imageView.layer.cornerRadius =27;
       
        
        imageView.layer.masksToBounds  = YES;
        

        [self.scrollView addSubview:imageView];
       
        
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * bannerArr.count, self.scrollView.frame.size.height);
   

    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    
   
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setNeedsStatusBarAppearanceUpdate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *location=[ prefs stringForKey:@"location"];
    self.CurrentLocation.text= location;

    }


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
       
        pageControlBeingUsed=YES;
        //self.addvendor.hidden=NO ;
    }
     self.addvendor.hidden=YES;
    
   

   }


- (IBAction)changePage {
    // Update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    
    pageControlBeingUsed = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
     pageControlBeingUsed = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //ensure that the end of scroll is fired.
   
   

    
    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
    
    if (addvendor==YES) {
        
        self.addvendor.hidden=YES;
         addvendor=NO;
    }
    else{
        self.addvendor.hidden=NO;
        addvendor=YES;

    }
    
    
    
}


- (IBAction)refreshClicked:(UIBarButtonItem*)sender {
    
    SearchListVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchListVC"];
    
    
    [ self.navigationController pushViewController: vc animated:YES];
    
    
}


#pragma mark buton Action Method

- (IBAction)Locationsearchbtn:(id)sender {
    
   
    
     SearchAreaVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchArea"];
    vc.searchdelegate=self;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)utilities:(id)sender {
  
    [ self FetchfdatafromFirebase:@"Utilities" andimage:@""];
   }

- (IBAction)DailyNeed:(id)sender {
   //[self FetchfdatafromFirebase:@"Daily Needs"];
     [ self FetchfdatafromFirebase:@"Daily Needs" andimage:@""];

}
- (IBAction)Shopping:(id)sender {
   
     [ self FetchfdatafromFirebase:@"Shopping" andimage:@""];
   }

- (IBAction)Food:(id)sender {
       [ self FetchfdatafromFirebase:@"Food" andimage:@""];
}
- (IBAction)Entertainment:(id)sender {
   
     [ self FetchfdatafromFirebase:@"Entertainment" andimage:@""];
    
}
- (IBAction)Educattion:(id)sender {
  
     [ self FetchfdatafromFirebase:@"Health" andimage:@""];
}
- (IBAction)health:(id)sender {
   
     [ self FetchfdatafromFirebase:@"Education" andimage:@""];
}
- (IBAction)Hobby:(id)sender {
 
     [ self FetchfdatafromFirebase:@"Hobby" andimage:@""];
}


- (IBAction)Wellness:(id)sender {
    
    [ self FetchfdatafromFirebase:@"Wellness" andimage:@""];
}

- (IBAction)OWl:(id)sender {
    
    [ self FetchfdatafromFirebase:@"Owl" andimage:@""];
}
- (IBAction)MIsc:(id)sender {
    
    [ self FetchfdatafromFirebase:@"Misc" andimage:@""];
}
-(IBAction)Bookmamark:(id)sender {
    
    
    FAvvendorVC *vc=[self.storyboard  instantiateViewControllerWithIdentifier:@"FAvvendorVC"];
    [self.navigationController pushViewController:vc animated:YES];
   // [ self FetchfdatafromFirebase:@"Misc" andimage:@""];
}



 -(IBAction)AssVendor:(UIButton*)sender{
     
     
     
     
     EarnrewardVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Reward"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)Addvendor:(UIButton*)sender{
    
    
    
    
    EarnrewardVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Reward"];
    [self.navigationController pushViewController:vc animated:YES];
}

  -(void)nextviewcontroller:(NSString*)Category{
    

     SubcategoryVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SubcategoryVC"];
    
      vc.categoryname=Category;
      
      
      
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:Category forKey:@"Category"];
      
      [defaults synchronize];

    
     [self.navigationController pushViewController:vc animated:YES];
    
  }

-(void)FetchfdatafromFirebase:(NSString*)Categorname andimage:(NSString*)image{
    
    [self nextviewcontroller:Categorname];
    
}
-(void)sendDataBacktoController:(NSDictionary *)area{
    
    
      NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
      NSString *location=[prefs stringForKey:@"location"];
      self.CurrentLocation.text= location;
    
    }

-(void)fetchaddbanaer{
    
    
    
    if ([AppDelegate getDelegate].connected) {
        
        
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@", Baseurl @"getbanner"];
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        Serverhit * obj=[[ Serverhit alloc]init];
        [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            bannerArr =[ dictResponse valueForKey:@"data"];
            
            if (bannerArr.count==0) {
                
            }
            else{
                [self Addbanner];
                
                
            }
            
        }];
    }
    else{
        
        [self.navigationController.view makeToast:@"No Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionBottom];
    }
    
    
}

@end
