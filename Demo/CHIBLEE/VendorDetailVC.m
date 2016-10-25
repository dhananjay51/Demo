//
//  VendorDetailVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 15/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "VendorDetailVC.h"
#import "VendorDeatilCell.h"
#import "TLYShyNavBar.h"
#import "MapDirectionsViewController.h"
#import "Serverhit.h"
#import "MBProgressHUD.h"
#import "TLYShyNavBar.h"
#import "AppDelegate.h"
#import <Toast/UIView+Toast.h>
#import "FXBlurView.h"
#import  "UITextView+Placeholder.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "defineAllURL.h"
#import "UIImageView+WebCache.h"


@interface VendorDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * lat;
    NSString *log;
    NSArray *CommentArr;
    NSString *VendorID;
}
@end

 @implementation VendorDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
       popview.hidden=YES;
    blureview.hidden=YES;
    alertView.hidden=YES;
     Commenttxt.placeholder = @"Please review the vendor";

   
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    
    VendorID=[self.VendorDeataildict valueForKey:@"_id"];
    
    [self  fetchComment:VendorID];

   // self.shyNavBarManager.scrollView =scrollView;
    [scrollView contentSizeToFit];
    
    [self addDoneToolBarToKeyboard:Commenttxt];


    
    
   
[commentlisttable registerNib:[UINib nibWithNibName:@"VendorDeatilCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    self.navigationController.navigationBar.topItem.title = @"";

    //add map
    
    lat=[self.VendorDeataildict objectForKey:@"latitude"];
    log=[self.VendorDeataildict objectForKey:@"longitude"];
    CLLocationCoordinate2D coord;
      _theMapView.delegate=self;
    coord.latitude=[[NSString stringWithFormat:@"%@",lat] floatValue];
    coord.longitude=[[NSString stringWithFormat:@"%@",
                      log] floatValue];
    MKCoordinateRegion region1;
    region1.center=coord;
    region1.span.longitudeDelta=0.1; ;
    region1.span.latitudeDelta=0.1;;
    [_theMapView setRegion:region1 animated:YES];
    
       
    
    MKPointAnnotation *sourceAnnotation = [[MKPointAnnotation alloc]init];
    
    sourceAnnotation.coordinate=coord;
    
    [self.theMapView addAnnotation:sourceAnnotation];
    
    NSString *name=[ self.VendorDeataildict valueForKey:@"name"];
    NSString * address=[ self.VendorDeataildict valueForKey:@"address"];
    
     int Homedelivery=[[self.VendorDeataildict valueForKey:@"homeDelivery"]intValue];
      float Distance=[[self.VendorDeataildict valueForKey:@"distance"]floatValue
                    ];
    [bookmark setSelected:[[self.VendorDeataildict objectForKey:@"bookmark"]integerValue]];
    
    NSString *opentime=[self.VendorDeataildict valueForKey:@"openingTiming"];
    NSString * closetime=[self.VendorDeataildict valueForKey:@"closingTiming"];
    
    
    if (name ==nil ||name ==(id)[ NSNull null ])
    {
        name=@"";
        
    }
    if (address ==nil ||address ==(id)[ NSNull null ])
    {
        address=@"";
        
    }
  
    if (Distance ==0.0)
    {
        
        
    }
    if (Homedelivery==1) {
        
         homedelivery.text=@"Yes";
         homedelivery.hidden=NO;
    }
    else{
       // homedelivery.text=@"No";
        homedelivery.hidden=YES;
        _homedliveylabel.hidden=YES;
        self.homedeliveryicon.hidden=YES;
        
    }
    
    /*
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString* category = [defaults objectForKey:@"Category"];
    
    
    
    if([category isEqualToString:@"Entertainment"]) {
        homedelivery.hidden=YES;
        _homedliveylabel.hidden=YES;
        self.homedeliveryicon.hidden=YES;
    }
    
    else if ([category isEqualToString:@"Health"]){
        homedelivery.hidden=YES;
        _homedliveylabel.hidden=YES;
        self.homedeliveryicon.hidden=YES;

    }
    
    
    else if ([category isEqualToString:@"Education"]) {
        
        
        homedelivery.hidden=YES;
        _homedliveylabel.hidden=YES;
        self.homedeliveryicon.hidden=YES;

    }
    
    else if
        ([category isEqualToString:@"Hobby"]) {
            homedelivery.hidden=YES;
            _homedliveylabel.hidden=YES;
            self.homedeliveryicon.hidden=YES;
        }
    
    else if
        ([category isEqualToString:@"Wellness"]) {
            homedelivery.hidden=YES;
            _homedliveylabel.hidden=YES;
            self.homedeliveryicon.hidden=YES;

        }
    
    else if
        ([category isEqualToString:@"Owl"]) {
            homedelivery.hidden=YES;
            _homedliveylabel.hidden=YES;
            self.homedeliveryicon.hidden=YES;

        }
    
    */
    

    
    
    NSString* contacts=[NSString stringWithFormat:@"%@",[self.VendorDeataildict objectForKey:@"contact"]] ;
    if ([contacts isEqualToString:@"-"]) {
        contactbtn.enabled=NO;
    }
    else{
        contactbtn.enabled=YES;
    }
    
    
    avendorname.text=name;
    vendoraddress.text=address;
   
    float lat=[[ self.VendorDeataildict valueForKey:@"latitude"] floatValue];
    float log=[[ self.VendorDeataildict valueForKey:@"longitude"] floatValue];
    
    NSString *distance1=[self Findistance:lat andlong: log];
    
    

     distance.text = [NSString stringWithFormat:@"%@ %@ %@", @"Just", distance1,@"Kms away"];
     time.text=[ NSString stringWithFormat:@"%@"  "%@" "%@",opentime,@"-",closetime];
    int ratestart=[[ self.VendorDeataildict valueForKey:@"rating"]  intValue];
    
    
    if (ratestart==0) {
        ratingview. hidden=YES;
        
    }
    else{
        
        rating.text=[NSString stringWithFormat:@"%d", ratestart];
    }
    
    
    
   

    // Do any additional setup after loading the view.
}

   -(NSString*)Findistance:(float)lat andlong:(float)lon{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    float lat1 = [[prefs stringForKey:@"latitude"]floatValue ];
    float lon1 = [[prefs stringForKey:@"longitude"] floatValue];
    
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:lat1 longitude:lon1];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    NSString*disstr= [ NSString stringWithFormat:@"%.1f",distance/1000];
    
    return disstr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [CommentArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VendorDeatilCell * cell = (VendorDeatilCell*)[commentlisttable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"VendorDeatilCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *commnetdict=[CommentArr objectAtIndex:indexPath.row];
    NSString *username=[commnetdict valueForKey:@"commentUserName"];
    NSString  *commnetetxt=[ commnetdict valueForKey:@"commentText"];
    
    cell.usernem.text= username;
    cell.Commment.text= commnetetxt;
    NSString * userimage=[ commnetdict valueForKey:@"commentUserImageUrl"];
    float rating=[[ commnetdict valueForKey:@"commentRating"] floatValue];
    cell.Rating.text= [NSString stringWithFormat:@"%f", rating];
     cell.userimage.layer.cornerRadius = cell.userimage.frame.size.height/2;
     cell.userimage.clipsToBounds = YES;
    [cell.userimage sd_setImageWithURL:[NSURL URLWithString:userimage] placeholderImage:[UIImage imageNamed:@"."]];
    double commenttime=[[ commnetdict valueForKey:@"commentTime"]doubleValue ];
    double unixTimeStamp =commenttime;
    
    
    
    NSTimeInterval timeInterval=unixTimeStamp/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"dd MMM YYYY"];
    NSString *dateString=[dateformatter stringFromDate:date];
    cell.Time.text =dateString;



    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 86.0;
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
     MKCoordinateRegion mapRegion;
     mapRegion.center = mapView.userLocation.coordinate;
     mapRegion.span.latitudeDelta = 0.1;
    mapRegion.span.longitudeDelta = 0.1;
    [self.theMapView setRegion:mapRegion animated: YES];
    self.theMapView.showsUserLocation = YES;
}
-(IBAction)Fullview:(UIButton *)sender{
  
        lat=[self.VendorDeataildict objectForKey:@"latitude"];
         log=[ self.VendorDeataildict valueForKey:@"longitude"];
         NSString *name=[ self.VendorDeataildict valueForKey:@"name"];
        MapDirectionsViewController*vc=[ self.storyboard instantiateViewControllerWithIdentifier:@"MAP"];
        if (vc) {
            vc.vendorlat=lat;
            vc.vendorlon=log;
            vc.sourcename= name;
        }
        [ self.navigationController pushViewController:vc animated:YES];
        
    }

-(IBAction)Comment:(UIButton*)sender{
    
  
    popview.hidden=NO;
    blureview.hidden=NO;
    
}

-(IBAction)bookmark:(UIButton*)sender{
    int bokmarkstatus=[[ self.VendorDeataildict valueForKey:@"bookmark"]intValue];
    
    NSString *vendorId=[ self.VendorDeataildict valueForKey:@"_id"];
    
    NSString *action;
    
    
    
    
    if (sender.selected)
        
    {
        [sender setSelected: NO];
        
        
        
        if(bokmarkstatus==0)
        {
            action=@"1";
            
            
            
        }
        
        
        else
        {
            action=@"0";
            
            
            
        }
    }
    
    
    else
        
    {
        [sender setSelected: YES];
        
        
        
        if(bokmarkstatus==0)
        {
            action=@"1";
            
            
            
        }
        
        
        else
        {
            action=@"0";
            
            
        }
    }
    [ self bookmark: vendorId andaction:action];
     
     
     }

    
    
-(void)bookmark:(NSString*)venderid andaction:(NSString*)action
    {
        
        if ([AppDelegate getDelegate].connected)
        {
            
            
            if ([AppDelegate getDelegate].connected) {
                
                
                
                
                NSString *urlString = [NSString stringWithFormat:@"%@""/%@"@"/%@",Baseurl @"addbookmark",venderid,action];
                
                NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                Serverhit * obj=[[ Serverhit alloc]init];
                [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
                    //pagenumber=0;
                    int status=[[ dictResponse valueForKey:@"error"] intValue];
                    if (status==0) {
                        
                        
                       /// if  ([self.addbookmarkDelegate respondsToSelector:@selector(updatebookmark)]) {
                            
                            ///[self.addbookmarkDelegate performSelector:@selector(updatebookmark)];
                       // }
                       /// [ self.navigationController popViewControllerAnimated:YES];
                        
                        
                        
                        
                    }
                    
                    
                }];
            }
            else{
                
                
            }
            
            
            
            
        }
        else
        {
            //[MBProgressHUD showErrorWithStatus:@"No Internet Connection"];
            
        }
        
        
        
    }

     
-(IBAction)Callingbtn:(UIButton*)sender{
    
}
    




//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
  // popview.hidden=YES;
    //blureview.hidden=YES;
}

-(IBAction)Submited:(UIButton*)sender{
    alertView.hidden=NO;
    popview.hidden=YES;
    blureview.hidden=NO;
    
    if (Commenttxt.text.length==0) {
        
    }
     else if (sliderlabel.text.length==0)
     {
     }
    
    [self SubmitComment];
    
}


-(void)fetchComment:(NSString*)vendorId{
    
    if ([AppDelegate getDelegate].connected) {
        
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", Baseurl @"getcomments/",vendorId];
    
    NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Serverhit * obj=[[ Serverhit alloc]init];
    [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *CommentDict=[ dictResponse  valueForKey:@"data"];
        
        CommentArr =[ CommentDict valueForKey:@"result"];
        // NSDictionary * tem
        if (CommentArr.count==0) {
            [self.navigationController.view makeToast:@"No Comment"
                                             duration:1.0
                                             position:CSToastPositionCenter];
            
        }
        else{
            
            ContainerView.frame=CGRectMake(ContainerView.frame.origin.x,ContainerView.frame.origin.y ,ContainerView.frame.size.width, ContainerView.frame.size.height+[CommentArr count]*55);
            
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width ,ContainerView.frame.size.height);
            
            [ commentlisttable reloadData];
            
        }
        
    }];
    }
    else{
        [self.navigationController.view makeToast:@"No  Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionCenter];

    }


        

    
    
}

- (IBAction)sliderValueChanged:(id)sender
{
     // Set the label text to the value of the slider as it changes
    sliderlabel.text = [NSString stringWithFormat:@"%.2F",slidervalue.value];
    
   
}
-(void)SubmitComment{
    
    
    if ([AppDelegate getDelegate].connected) {
    
        
       
      NSString *urlString = [NSString stringWithFormat: Baseurl @"addcomment"];
        
       
         NSMutableDictionary * paramdict=[[ NSMutableDictionary alloc]init];
        [ paramdict setObject:Commenttxt.text forKey:@"commentText"];
        [ paramdict setObject:sliderlabel.text forKey:@"commentRating"];
        [ paramdict setObject:VendorID forKey:@"vendorId"];
        
        
        Serverhit * obj=[[ Serverhit alloc]init];
    
      [obj ServiceHitWithHttpString:paramdict :urlString :^(NSDictionary *dictResponse) {
        
        //self.VendorlistArr =[ dictResponse valueForKey:@"result"];
        
          
         
         
         
         
         [self performSelector:@selector(Vendorhide)
                    withObject:nil
                    afterDelay:1];
            [self fetchComment:VendorID];
         
        
       
               
    }];
    }
    else{
        [self.navigationController.view makeToast:@"No  Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionCenter];

    }
    

}





- (void)dealloc
{
#if DEBUG
    // Xcode8/iOS10 MKMapView bug workaround
    static NSMutableArray* unusedObjects;
    if (!unusedObjects)
        unusedObjects = [NSMutableArray new];
    [unusedObjects addObject:mapview];
#endif
}


-(void)Vendorhide{
    
    alertView.hidden=YES;
    blureview.hidden=YES;
}
-(IBAction)crossbtn:(UIButton*)sender{
    alertView.hidden=YES;
    blureview.hidden=YES;
    popview.hidden=YES;
}

-(void)addDoneToolBarToKeyboard:(UITextView *)textView
{
    UIToolbar* doneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    doneToolbar.barStyle = UIBarStyleBlackTranslucent;
    doneToolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClickedDismissKeyboard)],
                         nil];
    [doneToolbar sizeToFit];
    textView.inputAccessoryView = doneToolbar;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    Commenttxt = textView;
}

-(void)doneButtonClickedDismissKeyboard
{
    [Commenttxt resignFirstResponder];
}

@end
