//
//  VendorDetailVC.h
//  CHIBLEE
//
//  Created by Macbook Pro on 15/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MapKit/MapKit.h"
#import "FXBlurView.h"
@class TPKeyboardAvoidingScrollView;
@protocol AddbookmarkDelegate <NSObject>
- (void)updatebookmark ;

@end
@interface VendorDetailVC : UIViewController<MKMapViewDelegate ,MKAnnotation ,MKOverlay>
{
    IBOutlet UITableView *commentlisttable;
    IBOutlet UIView *ContainerView;
    IBOutlet TPKeyboardAvoidingScrollView *scrollView;
    IBOutlet UILabel *vendoraddress;
    IBOutlet UILabel *avendorname;
    IBOutlet UILabel *time;
    IBOutlet  UILabel *homedelivery;
    IBOutlet  UILabel *distance;
    IBOutlet  UIView* review;
    IBOutlet UIView *fullView;
    IBOutlet UIView *mapview;
    IBOutlet UIView *blureview;
    IBOutlet UIView *popview;
    IBOutlet UIView *alertView;
    IBOutlet  UITextView  *Commenttxt;
    IBOutlet UISlider *slidervalue;
    IBOutlet UILabel * sliderlabel;
    IBOutlet  UIImageView *blureimage;
    IBOutlet UIButton * contactbtn;
    IBOutlet UIButton*bookmark;
    IBOutlet UIView *ratingview;
    IBOutlet UILabel *rating;
    
    
    
}

 @property (strong, nonatomic) IBOutlet MKMapView *theMapView;
@property(nonatomic,weak) id <AddbookmarkDelegate> addbookmarkDelegate;

 @property(nonatomic,strong) NSDictionary*VendorDeataildict;


@property(nonatomic,strong)  IBOutlet UILabel * homedliveylabel;
@property(nonatomic,strong) IBOutlet UIImageView * homedeliveryicon;

-(IBAction)Comment:(UIButton*)sender;
-(IBAction)bookmark:(UIButton*)sender;
-(IBAction)Callingbtn:(UIButton*)sender;
-(IBAction)Fullview:(UIButton*)sender;



@end
