//
//  VenderListVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 07/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "VenderListVC.h"
#import "VendorListCell.h"
#import "ServiceHIt.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSData+Base64.h"
#import "defineAllURL.h"
#import "AnalyticsHelper.h"
#import "MBProgressHUD.h"
#import "Serverhit.h"
#import "UIImageView+WebCache.h"
#import "SearchAreaVC.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import <Toast/UIView+Toast.h>
#import "TLYShyNavBar.h"
#import "VendorDetailVC.h"
#import "AppDelegate.h"

#import "VendorDetailVC.h"
#import "UITextView+Placeholder.h"





@interface VenderListVC ()<UITableViewDelegate,UITableViewDataSource,searchDelegate,AddbookmarkDelegate>
{
   /// NSMutableDictionary *addvendorarr;
    NSArray *addvendorArr;
    UIRefreshControl *refreshControl;
    int pagenumber;
    BOOL indicatior;
    NSInteger _offsetRecords;
    BOOL   _allRecordsLoaded;
    BOOL   _dataLoaded;
     NSInteger  _totalRecordCount;
    NSString *category ;
}
@end

@implementation VenderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    popview.hidden=YES;
    blureview.hidden=YES;
    alertView.hidden=YES;
    Commenttxt.placeholder = @"Please review the vendor";
    /* Library code */
    ///self.shyNavBarManager.scrollView = Vendorlisttable;
   
    //[self.shyNavBarManager setExtensionView:locationview];
    filterview.hidden=YES;
     pagenumber=0;
    
    //[self initView];
     Vendorlisttable.tableFooterView.hidden = YES;

    
    
    
    
    if (self.elasticdict!=nil) {
         [self getElasticitemapi];
        
        
    }
      else{
          [self VendorlistAPI];


      }
    
    
   
     indicatior=NO;
    //bottom refresh
    refreshControl = [UIRefreshControl new];
    refreshControl.triggerVerticalOffset = 100.;
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    Vendorlisttable.bottomRefreshControl = refreshControl;
    
   self.navigationController.navigationBar.topItem.title = @"";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 22, 22);
    [button setImage:[UIImage imageNamed:@"Filter.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.rightBarButtonItem=barButton;
    
    
       [Vendorlisttable registerNib:[UINib nibWithNibName:@"VendorListCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    // Do any additional setup after loading the view.
    
    [self addDoneToolBarToKeyboard:Commenttxt];
}


-(void)viewWillAppear:(BOOL)animated{
       
     self.navigationItem.title=self.subcategoryname;

     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
     NSString *location=[ prefs stringForKey:@"location"];
     currentlocation.text= location;

    [self updatebookmark];
   
    
    
   

}
- (void)refresh {
    
    indicatior=YES;
    
     pagenumber=pagenumber+1;
    
    
    [self VendorlistAPI];
    
    [self performSelector:@selector(updateTable) withObject:nil
               afterDelay:1];
    
    [refreshControl endRefreshing];
    
    // Do refresh stuff here
}
-(void)updateTable
{
    
    [Vendorlisttable reloadData];
    
   
    [refreshControl endRefreshing];
    
}





-(IBAction)filter:(UIButton*)sender

{
    
    if (sender.selected==YES) {
        filterview.hidden=YES;
        sender.selected=NO;
    }
    else{
        filterview.hidden=NO;
        sender.selected=YES;
    }}
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
    
    return [self.VendorlistArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VendorListCell  * cell = (VendorListCell*)[Vendorlisttable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"VendorListCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
     cell.backgroundColor = [UIColor clearColor];
     cell.contentView.backgroundColor = [UIColor clearColor];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.callingbtn.buttonIndexPath=indexPath;
    cell.bookmark.buttonIndexPath=indexPath;
    cell.commentngbtn.buttonIndexPath=indexPath;
    
    [cell.callingbtn addTarget:self action:@selector(CallBtn:event:) forControlEvents:UIControlEventTouchUpInside];
     [cell.bookmark addTarget:self action:@selector(Bookmark:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.commentngbtn addTarget:self action:@selector(CommentBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    

    
   
    
     NSDictionary *tempdict=[self.VendorlistArr objectAtIndex:indexPath.row];
    
    /*if (first ==nil ||first ==(id)[ NSNull null ])
    {
*/
    
    [cell.bookmark setSelected:[[tempdict objectForKey:@"bookmark"] integerValue]];
    

    
       cell.VendorName.text=[tempdict valueForKey:@"name"];
       cell.VendorAddress.text=[tempdict valueForKey:@"address"];
      cell.VendorArea.text=  [ tempdict valueForKey:@"area"];
    
     int  homedelivey=[[tempdict valueForKey:@"homeDelivery"]intValue];
     int  rating=[[tempdict valueForKey:@"rating"] intValue];
    
    if (rating==0) {
        cell.ratingview.hidden=YES;
        
    }
    else{
     cell.rating.text=[NSString stringWithFormat:@"%d",rating];
    }
    
    
    
    if (homedelivey==1) {
        
        cell.homeDelivery.text=@"Yes";
         cell.homeDelivery.hidden=NO;
    }
    else{
        cell.homeDelivery.text=@"No";
        cell.homeDelivery.hidden=YES;
        cell.homedliveylabel.hidden=YES;
        cell.homedeliveryicon.hidden=YES;
        
    }/*
      if([category isEqualToString:@"Entertainment"]) {
         cell.homeDelivery.hidden=YES;
          cell.homedliveylabel.hidden=YES;
          cell.homedeliveryicon.hidden=YES;
    }
    
     else if ([category isEqualToString:@"Health"]){
          cell.homeDelivery.hidden=YES;
         cell.homedliveylabel.hidden=YES;
         cell.homedeliveryicon.hidden=YES;
    }
        
    
    else if ([category isEqualToString:@"Education"]) {
        
        
        cell.homeDelivery.hidden=YES;
        cell.homedliveylabel.hidden=YES;
        cell.homedeliveryicon.hidden=YES;
    }
    
    else if
        ([category isEqualToString:@"Hobby"]) {
          cell.homeDelivery.hidden=YES;
            cell.homedliveylabel.hidden=YES;
            cell.homedeliveryicon.hidden=YES;
    }

    else if
        ([category isEqualToString:@"Wellness"]) {
            cell.homeDelivery.hidden=YES;
             cell.homedliveylabel.hidden=YES;
            cell.homedeliveryicon.hidden=YES;
        }
    
    else if
        ([category isEqualToString:@"Owl"]) {
             cell.homeDelivery.hidden=YES;
            cell.homedliveylabel.hidden=YES;
            cell.homedeliveryicon.hidden=YES;
        }
    
*/



    
    
    
    NSString* contacts=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"contact"]] ;
    if ([contacts isEqualToString:@"-"]) {
        cell.callingbtn.enabled=NO;
    }
    else{
        cell.callingbtn.enabled=YES;
    }
    
    
     NSString *openshop=[tempdict valueForKey:@"openingTiming"];
       NSString * closeshop=[ tempdict valueForKey:@"closingTiming"];
      
      cell.Shoptime.text=[ NSString stringWithFormat:@"%@" "%@""%@",openshop,@"-",closeshop];
    
     float lat=[[ tempdict valueForKey:@"latitude"] floatValue];
     float log=[[ tempdict valueForKey:@"longitude"] floatValue];
    
     float distance=[[tempdict valueForKey:@"distance"]floatValue];//[self Findistance:lat andlong: log];
    
    
   cell.distance.text= [ NSString stringWithFormat:@"%.1f km", distance];
    
    
    return cell;
}
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     VendorDetailVC *vc=[self.storyboard
                        instantiateViewControllerWithIdentifier:@"VendorDetailVC"];
     vc.VendorDeataildict=[self.VendorlistArr objectAtIndex:indexPath.row];
     
     [AppDelegate getDelegate].indexPath=indexPath;
    
     [self.navigationController pushViewController:vc animated:YES];
   
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 202.0;
}

-(NSString*)Findistance:(float)lat andlong:(float)lon{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    float lat1 = [[prefs stringForKey:@"latitude"]floatValue ];
    float lon1 = [[prefs stringForKey:@"longitude"] floatValue];
    
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:lat1 longitude:lon1];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    NSString*disstr= [ NSString stringWithFormat:@"%.1f km",distance/1000];
    
    return disstr;
}

#pragma mark Reply Button
-(IBAction)CallBtn:(id)sender event:(id)event
{
    CustomButton *btn = (CustomButton *)sender;
    NSIndexPath *indexPath = btn.buttonIndexPath;
    
    NSDictionary * RecentWishdict=[self.VendorlistArr objectAtIndex:indexPath.row];
    
    int conatact=[[ RecentWishdict valueForKey:@"contact"]intValue];
    
    NSString *contact1=[NSString stringWithFormat:@"%d",conatact];
    NSString *venderid=[ RecentWishdict valueForKey:@"_id"];
    
    
NSString *urlString = [NSString stringWithFormat:@"%@%@/%@",Baseurl @"addcontactcallhistory/",venderid,contact1];
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        Serverhit * obj=[[ Serverhit alloc]init];
        [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
            
        
        }];
    

     NSString *newString = [contact1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
     NSString *phoneNumber = [@"tel://"stringByAppendingString:newString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: phoneNumber]];
    
    
}

#pragma mark Reply Button
-(IBAction)Bookmark:(id)sender event:(id)event
{
     CustomButton *btn = (CustomButton *)sender;
     NSIndexPath *indexPath = btn.buttonIndexPath;
    
    NSDictionary * RecentWishdict=[self.VendorlistArr objectAtIndex:indexPath.row];
    
     int bokmarkstatus=[[ RecentWishdict valueForKey:@"bookmark"]intValue];
    
      NSString *vendorId=[ RecentWishdict valueForKey:@"_id"];
    
      NSString *action;
    
    
   
        
        if (btn.selected)
            
        {
            [btn setSelected: NO];
            
            NSMutableDictionary *mutableDict = [RecentWishdict mutableCopy];
            [mutableDict setObject:[NSString stringWithFormat:@"%d",0] forKey:@"bookmark"];
            RecentWishdict = [mutableDict mutableCopy];
            NSMutableArray*muarr=[self.VendorlistArr mutableCopy];
            [muarr replaceObjectAtIndex:indexPath.row withObject:RecentWishdict];
            self.VendorlistArr=muarr;
            
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
            [btn setSelected: YES];
            
            NSMutableDictionary *mutableDict = [RecentWishdict mutableCopy];
            [mutableDict setObject:[NSString stringWithFormat:@"%d",1] forKey:@"bookmark"];
            // [mutableDict setObject:@"no" forKey:@"liked_var"];
            RecentWishdict = [mutableDict mutableCopy];
            NSMutableArray*muarr=[self.VendorlistArr mutableCopy];
            [muarr replaceObjectAtIndex:indexPath.row withObject:RecentWishdict];
            self.VendorlistArr=muarr;
            
            if(bokmarkstatus==0)
            {
                action=@"1";
                
                
                
            }
            
            
            else
            {
                action=@"0";
                
                
            }
        }
    VendorListCell*cell=(VendorListCell*)btn.superview.superview.superview;
    
    [ self WoWbtn: vendorId  cell:cell action:action];
    
    
}

-(void)WoWbtn:(NSString*)vendorId cell:(VendorListCell*)cell action:(NSString*)action
{
    
    if ([AppDelegate getDelegate].connected)
    {
        
        
        if ([AppDelegate getDelegate].connected) {
            
            
            
            
            NSString *urlString = [NSString stringWithFormat:@"%@""/%@"@"/%@", Baseurl @"addbookmark",vendorId,action];
            
             NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             Serverhit * obj=[[ Serverhit alloc]init];
             [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
                  //pagenumber=0;
                  int status=[[ dictResponse valueForKey:@"error"] intValue];
                 if (status==0) {
                     
                     
                   
                      [Vendorlisttable reloadData];
                   
                  
                 }
                 
               
            }];
        }
        else{
            
            
        }
        

        
        
    }
    else
    {
        [self.navigationController.view makeToast:@"No Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionBottom];

        //[SVProgressHUD showErrorWithStatus:@"No Internet Connection"];
        
        }



}



#pragma mark Reply Button
-(IBAction)CommentBtn:(id)sender event:(id)event
{
     CustomButton *btn = (CustomButton *)sender;
     NSIndexPath *indexPath = btn.buttonIndexPath;
    
     NSDictionary * RecentWishdict=[self.VendorlistArr objectAtIndex:indexPath.row];
    
    VendorDetailVC *vc=[self.storyboard  instantiateViewControllerWithIdentifier:@"VendorDetailVC"];
   vc.VendorDeataildict=RecentWishdict;
   [self.navigationController pushViewController:vc animated:YES];
    //popview.hidden=NO;
   // blureview.hidden=NO;
      
    
    
}






#pragma mark buton Action Method

- (IBAction)Locationsearchbtn:(id)sender {
    
    
    
    SearchAreaVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchArea"];
    vc.searchdelegate=self;
    [self.navigationController pushViewController:vc animated:YES];
    
}





-(void)VendorlistAPI{
    
    
    if (indicatior==YES) {
        
    }
    else{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    NSString *urlString = [NSString stringWithFormat: Baseurl @"getvendor"];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    double lat =[[prefs stringForKey:@"latitude"]doubleValue ];
    double lon = [[prefs stringForKey:@"longitude"] doubleValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *subcat = [defaults objectForKey:@"subCat"];
    
     NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    
    category = [defaults1 objectForKey:@"Category"];

      NSMutableDictionary * paramdict=[[ NSMutableDictionary alloc]init];
    
     [ paramdict setObject:category forKey:@"cat"];
    [ paramdict setObject:subcat forKey:@"subcat"];
    
     [paramdict setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
     [paramdict setObject:[NSNumber numberWithDouble:lon] forKey:@"lng"];
     [paramdict setObject:[NSNumber numberWithInt:pagenumber] forKey:@"page"];
     [paramdict setObject:[NSNumber numberWithInt:5] forKey:@"radius"];
    
    if ([AppDelegate getDelegate].connected==YES) {
        
    
   
    
        Serverhit * obj=[[ Serverhit alloc]init];
    
       [obj ServiceHitWithHttpString:paramdict :urlString :^(NSDictionary *dictResponse) {
        
        //self.VendorlistArr =[ dictResponse valueForKey:@"result"];
           NSString *mess=[ dictResponse valueForKey:@"message"];
           
          NSArray *temparr=[dictResponse valueForKey:@"data"];
          if (temparr.count>0) {
              
              if (pagenumber==0) {
                  
                 self.VendorlistArr=[temparr mutableCopy];
              }
              
              else
              
              {
                  
                   self.VendorlistArr= [[self.VendorlistArr arrayByAddingObjectsFromArray:temparr] mutableCopy];
              
              }
              [Vendorlisttable reloadData];
          }
          else{
              
                
              [self.navigationController.view makeToast:@"No Data"
                                               duration:1.0
                                               position:CSToastPositionCenter];
             
              
          }
         
        
    
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        
    }];
    
    }
    else{
        [self.navigationController.view makeToast:@"No Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionBottom];

    }
    }


-(void)Getvenderlist{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *location=[ prefs stringForKey:@"location"];
    currentlocation.text= location;
    
    if ([[AppDelegate getDelegate] connected]) {
        
        [MBProgressHUD  showHUDAddedTo:self.view animated:YES];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *subcat = [defaults objectForKey:@"subCat"];
        
        NSString *urlString =[NSString stringWithFormat:@"%@""%@""/%@""/%d", Baseurl @"v2/vendorbyarea/",subcat,[AppDelegate getDelegate].selectArea,0];
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        if ([AppDelegate getDelegate].connected==YES) {
            
        
        
        Serverhit * obj=[[ Serverhit alloc]init];
        [ obj Serverhit: encoded:^(NSDictionary *dictResponse) {
            NSLog(@"%@", dictResponse);
            
            NSString *mess=[ dictResponse valueForKey:@"message"];
            
            NSArray *temparr=[ dictResponse valueForKey:@"data"];
            if (temparr.count>0) {
                
                
                if (pagenumber==0) {
                    
                    
                    self.VendorlistArr=[temparr mutableCopy];
                }
                
                else
                    
                {
                    
                    self.VendorlistArr= [[self.VendorlistArr arrayByAddingObjectsFromArray:temparr ] mutableCopy];
                    
                }
                Vendorlisttable.dataSource=self;
                Vendorlisttable.delegate=self;
                [Vendorlisttable reloadData];
            }
            else{
                [self.VendorlistArr removeAllObjects];
                
                [self.navigationController.view makeToast:@"No Data Avaibale This Location"
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
                
                
            }
            
            
            [MBProgressHUD  hideHUDForView:self.view animated:YES];
            
        }];
        
        
        
    }
    }
    
    else{
        
        ///[SVProgressHUD showErrorWithStatus:@"No Internet connection"];
        [self.navigationController.view makeToast:@"No Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionBottom];

        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        
    }
    
    
    
}




-(void)sendDataBacktoController:(NSString *)area{
    
    
    [self VendorlistAPI];
    
    
    
    
}

-(IBAction)Nearestfilter:(id)sender{
    
}
-(IBAction)TopRatedfilter:(id)sender{
    pagenumber=0;
    
    if ([[AppDelegate getDelegate] connected]) {
        
        [MBProgressHUD  showHUDAddedTo:self.view animated:YES];
        
        
        NSString *urlString = Baseurl @"getvendorsbyrating";

        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        Serverhit * obj=[[ Serverhit alloc]init];
        [ obj Serverhit: encoded:^(NSDictionary *dictResponse) {
            NSLog(@"%@", dictResponse);
            
            NSString *mess=[ dictResponse valueForKey:@"message"];
            
            NSArray *temparr=[ dictResponse valueForKey:@"data"];
            if (temparr.count>0) {
                 filterview.hidden=YES;
                if (pagenumber==0) {
                    
                    
                    self.VendorlistArr=[temparr mutableCopy];
                }
                
                else
                    
                {
                    
                    self.VendorlistArr= [[self.VendorlistArr arrayByAddingObjectsFromArray:temparr] mutableCopy];
                    
                }
                Vendorlisttable.dataSource=self;
                Vendorlisttable.delegate=self;
                [Vendorlisttable reloadData];

            }
            else{
                
                [ self.VendorlistArr removeAllObjects];
                
                [self.navigationController.view makeToast:@"No Data Avaibale This Location"
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
                
                
            }
            
            
            [MBProgressHUD  hideHUDForView:self.view animated:YES];
            
        }];
        
        
        
    }
    
    else{
        
        [SVProgressHUD showErrorWithStatus:@"No Internet Connection"];
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        
    }
    

    
 
    
}
-(IBAction)openfilter:(id)sender{
    
}
-(IBAction)homeDeliveryffilter:(id)sender{
    
    pagenumber=0;
    [Vendorlisttable setAllowsSelection:NO];
    
    
    if (indicatior==YES) {
        
    }
    else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    NSString *urlString = [NSString stringWithFormat:Baseurl @"getVendorsByHomeDelivery"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    double lat = [[prefs stringForKey:@"latitude"]doubleValue ];
    double lon = [[prefs stringForKey:@"longitude"] doubleValue];
    
    
    NSMutableDictionary * paramdict=[[ NSMutableDictionary alloc]init];
    
    [paramdict setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [paramdict setObject:[NSNumber numberWithDouble:lon] forKey:@"lng"];
    [paramdict setObject:[NSNumber numberWithInt:pagenumber] forKey:@"page"];
    [paramdict setObject:[NSNumber numberWithInt:5] forKey:@"radius"];
    
    
    
    Serverhit * obj=[[ Serverhit alloc]init];
    
    [obj ServiceHitWithHttpString:paramdict :urlString :^(NSDictionary *dictResponse) {
        
        //self.VendorlistArr =[ dictResponse valueForKey:@"result"];
        NSString *mess=[ dictResponse valueForKey:@"message"];
        
        NSArray *temparr=[ dictResponse valueForKey:@"data"];
        if (temparr.count>0) {
            filterview.hidden=YES;
    ;
            if (pagenumber==0) {
                
                self.VendorlistArr=[temparr mutableCopy];
            }
            
            else
                
            {
                
                self.VendorlistArr= [[self.VendorlistArr arrayByAddingObjectsFromArray:temparr] mutableCopy];
                
            }
             [Vendorlisttable reloadData];
        }
        else{
            [ self.VendorlistArr removeAllObjects];

            [self.navigationController.view makeToast:@"No Data Avaibale"
                                             duration:1.0
                                             position:CSToastPositionCenter];
            
            
        }
        
       
        
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        
    }];
    

}

-(void)getElasticitemapi{
    
    
    if ([[AppDelegate getDelegate] connected]) {
        
         [MBProgressHUD  showHUDAddedTo:self.view animated:YES];
        
        
        NSString * categoey =[ self.elasticdict valueForKey:@"category"];
        NSString *  subcategory =[ self.elasticdict valueForKey:@"subCategory"];
        NSString *tag=[ self.elasticdict valueForKey:@"tags"];
        NSString *url=  Baseurl @"vendorbytag/";
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *location=[ prefs stringForKey:@"location"];
        currentlocation.text= location;

        
        
        NSString *urlString =[NSString stringWithFormat:@"%@"@"%@"@"/%@"@"/%@"@"/%@"@"/%d",url, categoey,subcategory,currentlocation.text,tag,pagenumber];
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        Serverhit * obj=[[ Serverhit alloc]init];
        [ obj Serverhit: encoded:^(NSDictionary *dictResponse) {
            NSLog(@"%@", dictResponse);
            
             NSString *mess=[ dictResponse valueForKey:@"message"];
            
            NSArray *temparr=[ dictResponse valueForKey:@"data"];
            if (temparr.count>0) {
                
                
                if (pagenumber==0) {
                    
                    
                    self.VendorlistArr=[temparr mutableCopy];
                }
                
                else
                    
                {
                    
                    self.VendorlistArr= [[self.VendorlistArr arrayByAddingObjectsFromArray:temparr ] mutableCopy];
                    
                }
                Vendorlisttable.dataSource=self;
                Vendorlisttable.delegate=self;
                [Vendorlisttable reloadData];
            }
            else{
                [self.VendorlistArr removeAllObjects];
                
                [self.navigationController.view makeToast:@"No Data Avaibale This Location"
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
                
                
            }
            
            
            [MBProgressHUD  hideHUDForView:self.view animated:YES];
            
        }];
        
        
        
    }
    
    else{
        
        [SVProgressHUD showErrorWithStatus:@"No Internet Connection"];
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        
    }
    
    

}

- (void)updatebookmark{
    
    
    NSIndexPath *indexPath=[AppDelegate getDelegate].indexPath;
    
    if (indexPath.row) {
       
        NSDictionary * RecentWishdict=[self.VendorlistArr objectAtIndex:indexPath.row];
        
        
        NSMutableDictionary *mutableDict = [RecentWishdict mutableCopy];
        [mutableDict setObject:[NSString stringWithFormat:@"%d",1] forKey:@"bookmark"];
        // [mutableDict setObject:@"no" forKey:@"liked_var"];
        RecentWishdict = [mutableDict mutableCopy];
        NSMutableArray*muarr=[self.VendorlistArr mutableCopy];
        [muarr replaceObjectAtIndex:indexPath.row withObject:RecentWishdict];
        self.VendorlistArr=muarr;
        [Vendorlisttable reloadData];

    }
    
    
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


- (IBAction)sliderValueChanged:(id)sender
{
    // Set the label text to the value of the slider as it changes
    sliderlabel.text = [NSString stringWithFormat:@"%.2F",slidervalue.value];
    
    
}
-(void)SubmitComment{
    
    
    if ([AppDelegate getDelegate].connected) {
        
        
        
        NSString *urlString = [NSString stringWithFormat:Baseurl @"/addcomment"];
        
        
        NSMutableDictionary * paramdict=[[ NSMutableDictionary alloc]init];
        [ paramdict setObject:Commenttxt.text forKey:@"commentText"];
        [ paramdict setObject:sliderlabel.text forKey:@"commentRating"];
        //[ paramdict setObject:VendorID forKey:@"vendorId"];
        
        
        Serverhit * obj=[[ Serverhit alloc]init];
        
        [obj ServiceHitWithHttpString:paramdict :urlString :^(NSDictionary *dictResponse) {
            
            //self.VendorlistArr =[ dictResponse valueForKey:@"result"];
            
            
            
            
            
            
            [self performSelector:@selector(Vendorhide)
                       withObject:nil
                       afterDelay:1];
           
            
            
            
            
        }];
    }
    else{
        
    }
    
    
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
- (void)initView
{
    _offsetRecords = 0;
    _allRecordsLoaded = NO;
    _dataLoaded = YES;
    
    UIView* footerView = [UIView new];
    footerView.frame   = CGRectMake(0.0,0.0, 320.0, 50);
    footerView.backgroundColor = [UIColor clearColor];
    UILabel* moreLabel = [UILabel new];
    moreLabel.frame    = CGRectMake(100.0,15.0,80.0, 30.0);
    moreLabel.text     = @"Loading....";
    moreLabel.font     = [UIFont fontWithName:@"AovelSans-Black" size:18];
    moreLabel.textColor = [UIColor whiteColor];
    moreLabel.backgroundColor = [UIColor clearColor];
    UIActivityIndicatorView*  loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingIndicator setFrame:CGRectMake(175,10.0, 45, 45)];
    [footerView addSubview:loadingIndicator];
    [loadingIndicator setBackgroundColor:[UIColor clearColor]];
    [loadingIndicator startAnimating];
    [footerView addSubview:moreLabel];
    Vendorlisttable.tableFooterView = footerView;
    Vendorlisttable.tableFooterView.backgroundColor = [UIColor clearColor];
    
}
/*
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    NSLog(@"height = %f" @" y =%f",scrollView.contentSize.height,scrollView.contentOffset.y);
    NSLog(@"offsetrecord = %d" @" totalListCount = %d",_offsetRecords,_totalRecordCount);
    
    
    if (_offsetRecords >= _totalRecordCount)
    {
        Vendorlisttable.tableFooterView.hidden = YES;
        _allRecordsLoaded = YES;
    }
    
    if (_dataLoaded == YES)
    {
        if(scrollView.contentSize.height - scrollView.contentOffset.y <= 600)
        {
            //load more records
            NSLog(@"load more records ..... ");
            Vendorlisttable.tableFooterView.hidden = NO;
            
        }
    }
    
}
#pragma mark load more records:-
-(void)loadMoreRecords:(NSString*)strCat
{
    // AppDelegate* appDelegate=(AppDeleg#ate *)[UIApplication sharedApplication].delegate;
    if([AppDelegate getDelegate].connected==YES)
    {
        _allRecordsLoaded = NO;
        _dataLoaded       = NO;
        
    }
    
    
}

#pragma mark -
#pragma mark dataAvailable Load:-
#pragma mark -
/*
-(void)dataAvailabletoLoad{
    
    NSInteger comingDataCount;
    
    
        
        comingDataCount = [_listServerResponce getDoctorListCount];
        
        if (comingDataCount> 0){
            if (_listArray == nil)
                _listArray = [[NSMutableArray alloc] initWithArray:[_listServerResponce getDoctorList]];
        }
        if(_listArray.count == 0)
        {
            [[[UIAlertView new] initWithTitle:@"PockDoc" message:@"No records found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            _table.hidden = YES;
        }
        
    }
    else if ([_titleString isEqualToString:@"Diagnostics"]&&obj==_listServerResponce){
        
        comingDataCount = [_listServerResponce getDiagnosticsListCount];
        
        if (comingDataCount> 0){
            _totalRecordCount = [_listServerResponce getDiagnosticsListCount];
            
            if (_listArray == nil)
                _listArray = [[NSMutableArray alloc] initWithArray:[_listServerResponce getDiagnosticsList]];
            else {
                // NSArray* first = [[NSArray alloc] initWithArray:_listArray];
                NSArray* last  =[[NSArray alloc]initWithArray:[_listServerResponce getDiagnosticsList]];
                //[_listArray removeAllObjects];
                // _listArray = [first arrayByAddingObjectsFromArray:last];
                _listArray = [_listArray arrayByAddingObjectsFromArray:last];
                //first =nil;
                last = nil;
                // NSLog(@"all data count=%d",_listArray.count);
                
            }
            
            // if(_listArray.count < 10)
            if(_offsetRecords < _offsetRecords+max_Count)
                _table.tableFooterView.hidden = YES;
            
            else
                _table.tableFooterView.hidden = NO;
            
            // _table.hidden = NO;
            // [_table reloadData];
            _offsetRecords = _offsetRecords + max_Count+1;
            _dataLoaded = YES;
            _allRecordsLoaded = NO;
            //            NSLog(@"all data count=%d",_listArray.count);
            //            NSLog(@"%@",_listArray);
            
        }
        else{
            _table.tableFooterView.hidden = YES;
            [[[UIAlertView new] initWithTitle:@"PockDoc" message:@"No more records found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
        
        if(_listArray.count == 0)
        {
            [[[UIAlertView new] initWithTitle:@"PockDoc" message:@"No records found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            _table.hidden = YES;
        }
    }

    if (.count > 0)
    {
        _table.hidden = NO;
        // _offsetRecords = _offsetRecords + max_Count;
        [_table reloadData];
        
        if(_listArray.count <= 10)
            [_table setContentOffset:CGPointZero animated:NO];
        
        
    }
    
    */


  @end
