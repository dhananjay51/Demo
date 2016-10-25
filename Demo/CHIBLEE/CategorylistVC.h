//
//  ViewController.h
//  CHIBLEE
//
//  Created by Shailendra Pandey on 12/5/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;
@interface CategorylistVC : UIViewController<  NSURLConnectionDelegate,UIScrollViewDelegate>


{
    IBOutlet UIView * containerview;
    IBOutlet UIImageView * utilitiesimage;
    IBOutlet  UIImageView * dailyneedimage;
    IBOutlet  UIImageView *  hobbymage;
    IBOutlet  UIImageView * fooddimage;
    IBOutlet  UIImageView * shopimage;
    IBOutlet  UIImageView * miscdimage;
    IBOutlet  UIImageView * healthimage;
    IBOutlet  UIImageView * owlimage;;
    BOOL pageControlBeingUsed;
    }
@property(nonatomic,strong) IBOutlet UIBarButtonItem *sidebarButton;

@property(nonatomic,weak) IBOutlet UIButton *dailyNeedbtn;
@property(nonatomic,weak) IBOutlet UIButton *foodbtn;
@property(nonatomic,weak) IBOutlet UIButton *healthbtn;
@property(nonatomic,weak) IBOutlet UIButton *hobbybtn;
@property(nonatomic,weak) IBOutlet UIButton *miscbtn;
@property(nonatomic,weak) IBOutlet UIButton *owlbtn;
@property(nonatomic,weak) IBOutlet UIButton *shoppinbtn;
@property(nonatomic,weak) IBOutlet UIButton *utilities;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (nonatomic, retain) IBOutlet  UILabel *CurrentLocation;;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView1;
@property(nonatomic,strong) IBOutlet UIButton *addvendor;

- (IBAction)changePage;
@end

