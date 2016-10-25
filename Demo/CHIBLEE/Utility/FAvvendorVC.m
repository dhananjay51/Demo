//
//  FAvvendorVC.m
//  CHIBLEE
//
//  Created by vikas on 4/29/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "FAvvendorVC.h"

#import "fontello.h"
#import "UIColor+Hex.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "Serverhit.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "VendorListCell.h"
#import "VendorDetailVC.h"
#import "SVProgressHUD.h"
#import "VendorDetailVC.h"
#import "defineAllURL.h"
#import <Toast/UIView+Toast.h>

@interface FAvvendorVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray*vendorarr;
    NSDictionary*tempDict;
    IBOutlet UITableView*datatable;
}
@end

@implementation FAvvendorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self fetchBookmark];
    placeholderimg.hidden=YES;
    _placeholdername.hidden=YES;
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    
    // [UIColor colorWithRed:30/255.f green:160/255.f blue:67/255.f alpha:1]];
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
     [datatable registerNib:[UINib nibWithNibName:@"VendorListCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

-(void)viewWillAppear:(BOOL)animated
{self.navigationItem.title=@"Bookmark";
    

   }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return vendorarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)

indexPath{
VendorListCell  * cell = (VendorListCell*)[datatable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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



NSDictionary *tempdict=[vendorarr objectAtIndex:indexPath.row];

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
        
    }
///cell.rating.text=[NSString stringWithFormat:@"%d",rating];


/*
if (homedelivey==1) {
    
    cell.homeDelivery.text=@"Yes";
}
else{
    cell.homeDelivery.text=@"No";
    
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
NSString *distance=[self Findistance:lat andlong: log];
cell.distance.text= distance;


return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VendorDetailVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"VendorDetailVC"];
    vc.VendorDeataildict=[vendorarr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 203.0;
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
    
    
   
    
    NSDictionary * RecentWishdict=[vendorarr objectAtIndex:indexPath.row];
    NSString *conatact=[ RecentWishdict valueForKey:@"contact"];
    
    
    NSString *newString = [conatact stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *phoneNumber = [@"tel://"stringByAppendingString:newString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: phoneNumber]];
    

    
}

#pragma mark Reply Button
-(IBAction)Bookmark:(id)sender event:(id)event
{
    CustomButton *btn = (CustomButton *)sender;
    NSIndexPath *indexPath = btn.buttonIndexPath;
    
   
    
    NSDictionary * RecentWishdict=[vendorarr objectAtIndex:indexPath.row];
    
    int bokmarkstatus=[[ RecentWishdict valueForKey:@"bookmark"]intValue];
    
    NSString *vendorId=[ RecentWishdict valueForKey:@"_id"];
    
    NSString *action;
    
    [btn setSelected: NO];
    
    NSMutableDictionary *mutableDict = [RecentWishdict mutableCopy];
    [mutableDict setObject:[NSString stringWithFormat:@"%d",0] forKey:@"bookmark"];
    // [mutableDict setObject:@"no" forKey:@"liked_var"];
    RecentWishdict = [mutableDict mutableCopy];
    NSMutableArray*muarr=[vendorarr mutableCopy];
    [muarr replaceObjectAtIndex:indexPath.row withObject:RecentWishdict];
    vendorarr=muarr;
    [ muarr removeObjectAtIndex:indexPath.row];
    
    if(bokmarkstatus==0)
    {
        action=@"1";
        
        
        
    }
    
    
    else
    {
        action=@"0";
        
        
        
    }


    VendorListCell*cell=(VendorListCell*)btn.superview.superview.superview;
    
    [ self WoWbtn: vendorId  cell:cell action:action];
    

}

-(void)WoWbtn:(NSString*)vendorId cell:(VendorListCell*)cell action:(NSString*)action
{
    
    if ([AppDelegate getDelegate].connected)
    {
        
        
        if ([AppDelegate getDelegate].connected) {
            
            
            
            
            NSString *urlString = [NSString stringWithFormat:@"%@""/%@"@"/%@",Baseurl @"addbookmark",vendorId,action];
            
            NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            Serverhit * obj=[[ Serverhit alloc]init];
            [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
                //pagenumber=0;
                int status=[[ dictResponse valueForKey:@"error"] intValue];
                if (status==0) {
                    
                    
                    
                    
                    
                    [datatable reloadData];
                }
                
                
            }];
        }
        else{
            
            

        }
        
        
        
        
    }
    else
    {
        [self.navigationController.view makeToast:@"No  Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionCenter];
        
    }
    
    
    
}



#pragma mark Reply Button
-(IBAction)CommentBtn:(id)sender event:(id)event
{
    CustomButton *btn = (CustomButton *)sender;
    NSIndexPath *indexPath = btn.buttonIndexPath;
    
    NSDictionary * RecentWishdict=[vendorarr objectAtIndex:indexPath.row];
    VendorDetailVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"VendorDetailVC"];
    vc.VendorDeataildict=RecentWishdict;
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)fetchBookmark{
    
    if ([AppDelegate getDelegate].connected) {
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        
        NSString *urlString = [NSString stringWithFormat:@"%@%d",Baseurl @"getbookmark/",0];
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        Serverhit * obj=[[ Serverhit alloc]init];
        [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            vendorarr=[ dictResponse valueForKey:@"data"];
            // NSDictionary * tem
            if (vendorarr.count==0) {
                  //placeholderimg.hidden=NO;
                placeholderimg.hidden=NO;
                _placeholdername.hidden=NO;
            }
            else{
                
                placeholderimg.hidden=YES;
                _placeholdername.hidden=YES;
                [  datatable reloadData];
                
            }
            
        }];
    }
    else{
        [self.navigationController.view makeToast:@"No  Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionCenter];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
