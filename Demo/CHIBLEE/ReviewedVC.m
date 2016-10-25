//
//  ReviewedVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "ReviewedVC.h"
#import "ReviewCell.h"
#import "EditProfileVC.h"
#import "AppDelegate.h"
#import "Serverhit.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/UIView+Toast.h>
#import "defineAllURL.h"

@interface ReviewedVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * ReveiewArr;
}
@end

@implementation ReviewedVC

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
    
    self.userimage.layer.cornerRadius = self.userimage.frame.size.height/2;
    self.userimage.clipsToBounds = YES;
    
    [self.reviewtabel registerNib:[UINib nibWithNibName:@"ReviewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self GetReviewApiList];
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
    
    return [ ReveiewArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ReviewCell * cell = (ReviewCell*)[self.reviewtabel dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"ReviewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        
        
    }
    
     NSDictionary *tempdict=[ ReveiewArr objectAtIndex:indexPath.row];
    
      NSArray * venderarr=[tempdict valueForKey:@"vendorDetail"];
    
      NSDictionary * venderetemp=[ venderarr objectAtIndex:0];
    
    
    NSString * vandername=[ venderetemp valueForKey:@"name"];
    NSString * Area=[ venderetemp valueForKey:@"area"];
    NSString * address=[ venderetemp valueForKey:@"address"];
    cell.vendername.text=vandername;
    cell.Area.text= Area;
    cell.Address.text= address;
    
  
    NSString * comment=[ tempdict valueForKey:@"commentText"];
    
    
    cell.commentetx.text= comment;
    
    float rating=[[ tempdict valueForKey:@"commentRating"] floatValue];
    cell.Rating.text= [NSString stringWithFormat:@"%f", rating];
    
    double commenttime=[[ tempdict valueForKey:@"commentTime"]doubleValue ];
    double unixTimeStamp =commenttime;
    
    
     NSTimeInterval timeInterval=unixTimeStamp/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@" MMM dd, YYYY hh:mm a"];
    NSString *dateString=[dateformatter stringFromDate:date];
    cell.time.text =dateString;
    

    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 230.0;
}
-(IBAction)Editprofile:(UIButton*)sender{
    EditProfileVC *vc=[ self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileVC"];
   
    
    [self.parentNavigationController pushViewController:vc animated:YES];
    
}


-(void)GetReviewApiList{
    
    
    
    if ([AppDelegate getDelegate].connected) {
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSString *urlString = [NSString stringWithFormat:@"%@", Baseurl @"getusercomments"];
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        Serverhit * obj=[[ Serverhit alloc]init];
        [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSDictionary *CommentDict=[ dictResponse  valueForKey:@"data"];
            
            ReveiewArr =[ CommentDict valueForKey:@"result"];
            // NSDictionary * tem
            if (ReveiewArr.count==0) {
                
                
                [self.navigationController.view makeToast:@"No Review"
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
                
            }
            else{
                
                 _reveiwcount.text=[ NSString stringWithFormat:@"%lu", (unsigned long)[ReveiewArr count]];
                
                 [_reviewtabel reloadData];
                
                
            }
            
        }];
    }
    
    else {
        
          [self.navigationController.view makeToast:@"No Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionCenter];
        }
    
    
}

@end
