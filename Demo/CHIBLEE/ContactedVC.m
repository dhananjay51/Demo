//
//  ContactedVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "ContactedVC.h"
#import "CotactedCell.h"
#import "TLYShyNavBar.h"
#import "EditProfileVC.h"
#import "AppDelegate.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Serverhit.h"
#import "defineAllURL.h"
#import <Toast/UIView+Toast.h>

@interface ContactedVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray * contactArr;
}
@end

@implementation ContactedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *namestr = [defaults objectForKey:@"userName"];
    NSString *imgstr = [defaults objectForKey:@"userImg"];
   
    self.username.text=namestr;
    
    NSURL* url = [NSURL URLWithString:imgstr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   self.userimage.image = [UIImage imageWithData:data];
                               }
                           
                           }];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *location=[prefs stringForKey:@"location"];
    self.userlocation.text= location;
    

    
    
   // self.shyNavBarManager.scrollView =self.contactedtabel;
    
   /// [self.shyNavBarManager setExtensionView:self.userview];
    self.userimage.layer.cornerRadius = self.userimage.frame.size.height/2;
    self.userimage.clipsToBounds = YES;
    
      [self.contactedtabel registerNib:[UINib nibWithNibName:@"CotactedCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self GetConatctApiList];
    // Do any additional setup after loading the view.
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
    
    return [ contactArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CotactedCell * cell = (CotactedCell*)[self.contactedtabel dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"CotactedCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    
    
     NSDictionary * temp=[contactArr objectAtIndex:indexPath.row];
     NSArray * vanderArr=[ temp valueForKey:@"vendorDetail"];
    NSDictionary * venderDict=[ vanderArr objectAtIndex:0];
    
    NSString *vendername=[ venderDict valueForKey:@"name"];
    NSString * area=[ venderDict valueForKey:@"area"];
    NSString * address=[ venderDict valueForKey:@"address"];
    NSArray * timingarr=[ temp valueForKey:@"timing"];
    NSString* commenttime=[ NSString stringWithFormat:@"%@",[ timingarr  objectAtIndex:0]];
    
    
    
    double unixTimeStamp =[commenttime doubleValue];
    
    
    
    
    NSTimeInterval timeInterval=unixTimeStamp/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@" MMM dd, YYYY hh:mm a"];
    NSString *dateString=[dateformatter stringFromDate:date];
    cell.time.text =dateString;

     
    
    cell.vednername.text= vendername;
    cell.area.text=area;
    cell.address.text=address;
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180.0;
}

-(IBAction)Editprofile:(UIButton*)sender{
    
    EditProfileVC *vc=[ self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileVC"];
   
    [self.parentNavigationController pushViewController:vc animated:YES];

}

-(void)GetConatctApiList{
    
    
    
    if ([AppDelegate getDelegate].connected) {
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSString *urlString = [NSString stringWithFormat:@"%@", Baseurl @"getcontactcallhistory"];
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        Serverhit * obj=[[ Serverhit alloc]init];
        [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
           /// NSDictionary *CommentDict=[ dictResponse  valueForKey:@"data"];
            
            contactArr =[ dictResponse valueForKey:@"data"];
            // NSDictionary * tem
            if (contactArr.count==0) {
                [self.navigationController.view makeToast:@"No Record Found"
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
                
            }
            else{
                
                 self.Totalconatact.text=[ NSString stringWithFormat:@"%lu", (unsigned long)[contactArr count]];
                // _reveiwcount.text=[ NSString stringWithFormat:@"%@d", [ReveiewArr z]
                
                [ _contactedtabel reloadData];
                
                
            }
            
        }];
    }
    else{
        
        [self.navigationController.view makeToast:@"No Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionCenter];
        
    }
    
    
}

@end
