//
//  SubcategoryVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 05/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "SubcategoryVC.h"
#import "SubcategoryCell.h"

#import "VenderListVC.h"
#import "MBProgressHUD.h"
#import "TLYShyNavBar.h"
#import "Serverhit.h"
#import "AppDelegate.h"
#import "SearchAreaVC.h"
#import "defineAllURL.h"
#import "UIImageView+WebCache.h"
#import <Toast/UIView+Toast.h>


@interface SubcategoryVC ()<searchDelegate>

@end

@implementation SubcategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.shyNavBarManager.scrollView =subcategorytable;
    [self.shyNavBarManager setExtensionView:locationview];
    
    [self  fetchSubcategory];
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     self.navigationController.navigationBar.topItem.title = @"";
   
    
    [subcategorytable registerNib:[UINib nibWithNibName:@"SubcategoryCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    

        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
  
    
    // self.title=self.subcategoryname;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    
   /* NSString *strUrl = [NSString stringWithFormat:@"https://chiblee-app-c2f87.firebaseio.com/Category/"];
    NSString *substring=[NSString stringWithFormat:@"%@%@", strUrl,self.categoryname];
    FIRDatabaseReference *ref = [[FIRDatabase database] referenceFromURL:substring];
    [ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSArray *post = snapshot.value;
        if (post.count!=0) {
            _subcategoryArr=post;
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            [ subcategorytable reloadData];
        }
        
    }];
    */
       // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
     self.navigationItem.title=self.categoryname;;
       [self setNeedsStatusBarAppearanceUpdate];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *location=[ prefs stringForKey:@"location"];
    currentlocation.text= location;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.subcategoryArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubcategoryCell  * cell = (SubcategoryCell*)[subcategorytable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"SubcategoryCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
      NSDictionary *tempdict = [self.subcategoryArr objectAtIndex:indexPath.row];
    NSString *subname= [ tempdict valueForKey:@"name"];
      NSString *image= [ tempdict valueForKey:@"iosImageUrl"];
    if(image==nil||image==(id)[NSNull null])
    {
        image=@"";
    }

    
   
    cell.subname.text= subname;
    
    [cell.subimage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    
    
    if ( indexPath.row % 2 == 0 )
        cell.backgroundColor = [UIColor  whiteColor];
    else{
        [cell setBackgroundColor: [self colorWithHexString:@"F8F7F7"]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    
    if ([self.Vendor isEqualToString:@"Vendor"]) {
        NSString *subcategoaryname= [self.subcategoryArr objectAtIndex:indexPath.row];
        
        
        [self.subcategorydelegate selectsubcategory:subcategoaryname];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
    
      VenderListVC *vc=[ self.storyboard instantiateViewControllerWithIdentifier:@"VenderListVC"];
     NSDictionary * tempdict=[self.subcategoryArr objectAtIndex:indexPath.row];

        vc.subcategoryname=[tempdict valueForKey:@"name"];
        
        [self.subcategoryArr objectAtIndex:indexPath.row];
     vc.Categoryname=self.categoryname;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:vc.subcategoryname forKey:@"subCat"];
    
    [defaults synchronize];

     [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)fetchSubcategory{
    
    
    
    if ([AppDelegate getDelegate].connected) {
        

    
    
     NSString *urlString = [NSString stringWithFormat:@"%@%@", Baseurl @"subcategory/",self.categoryname];
    
    NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     Serverhit * obj=[[ Serverhit alloc]init];
     [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
        
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *subcatArr =[ dictResponse valueForKey:@"data"];
         
         if (subcatArr.count==0) {
             
         }
         else{
             
             NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
            self.subcategoryArr=[subcatArr sortedArrayUsingDescriptors:@[sort]];
             
        ///self.subcategoryArr = [subcatArr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
       // self.subcategoryArr = [subcatArr sortedArrayUsingSelector:@selector(compare:)];
        
         [ subcategorytable reloadData];
        
         }
         
     }];
    }
    else{
        
        [self.navigationController.view makeToast:@"No Internet Connection"
                                         duration:1.0
                                         position:CSToastPositionBottom];
    }

    
}


#pragma mark buton Action Method

- (IBAction)Locationsearchbtn:(id)sender {
    
    
    
    SearchAreaVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchArea"];
    vc.searchdelegate=self;
    [self.navigationController pushViewController:vc animated:YES];
    
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
-(void)sendDataBacktoController:(NSDictionary *)area{
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *location=[prefs stringForKey:@"location"];
    currentlocation.text= location;
    
}

@end
