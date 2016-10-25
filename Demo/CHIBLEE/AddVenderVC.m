//
//  AddVenderVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "AddVenderVC.h"
#import "AddvenderCell.h"
#import "SWRevealViewController.h"
#import "Serverhit.h"
#import "AppDelegate.h"
#import "defineAllURL.h"
#import <Toast/UIView+Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface AddVenderVC ()
{
    NSArray *AddvenderArr;
}
@end

@implementation AddVenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.title=@"ADDED VENDORS";

    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    [self.addvendertabel registerNib:[UINib nibWithNibName:@"AddvenderCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    [self GetVenderApiList];
    
    
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
    
    return [ AddvenderArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AddvenderCell * cell = (AddvenderCell*)[self.addvendertabel dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"AddvenderCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    
     NSDictionary * tempdict=[ AddvenderArr objectAtIndex:indexPath.row];
     NSString * vendername=[ tempdict valueForKey:@"name"];
     NSString * address=[ tempdict valueForKey:@"address"];
     NSString * area=[ tempdict valueForKey:@"area"];
     NSString * opentime =[ tempdict valueForKey:@"openingTiming"];
     NSString * closetime =[ tempdict valueForKey:@"closingTiming"];
     NSString * distance =[ tempdict valueForKey:@""];
    int stataus=[[tempdict valueForKey:@"status"]intValue];
    double savetime=[[ tempdict valueForKey:@"saveTime"] doubleValue];
    
    cell.vendername.text=vendername;
    cell.address.text=address;
    cell.area.text =area;
    cell.timing.text=[ NSString stringWithFormat:@"%@-%@", opentime,closetime];
    
    if (stataus==0) {
        cell.containerview.hidden=YES;
        cell.ratingimg.hidden=YES;
        cell.ratiing.hidden=YES;
        
    }
    
    else if  (stataus==1) {
        cell.containerview.hidden=NO;
        cell.deletebtn.hidden=YES;
        cell.Status.image=[UIImage imageNamed:@"approved.png"];

    }
    
    else{
        
    cell.containerview.hidden=YES;
        cell.ratingimg.hidden=YES;
        cell.ratiing.hidden=YES;
         cell.deletebtn.hidden=YES;
     cell.Status.image=[UIImage imageNamed:@"dis.png"];
    }
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSDictionary * tempdict=[ AddvenderArr objectAtIndex:indexPath.row];
   
    int stataus=[[tempdict valueForKey:@"status"]intValue];
   
    
       if (stataus==0) {
           return 160;
        
       }
    
    else if  (stataus==1) {
       
        return 165.0;
    }
    
    else{
        return 160;
        
    }
    
    
}

-(void)GetVenderApiList{
    

        
        if ([AppDelegate getDelegate].connected) {
            
            
              [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            NSString *urlString = [NSString stringWithFormat:@"%@", Baseurl @"getaddednewvendor"];
            
            NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            Serverhit * obj=[[ Serverhit alloc]init];
            [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
               /// NSDictionary *CommentDict=[ dictResponse  valueForKey:@"data"];
                
                AddvenderArr =[ dictResponse valueForKey:@"result"];
                // NSDictionary * tem
                if (AddvenderArr.count==0) {
                    [self.navigationController.view makeToast:@"No  Add Vendor"
                                                     duration:1.0
                                                     position:CSToastPositionCenter];
                    
                }
                else{
                  
                     _vendorcount.text=[ NSString stringWithFormat:@"%lu", (unsigned long)[AddvenderArr count]];
                    [ _addvendertabel reloadData];
                    
                    
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
