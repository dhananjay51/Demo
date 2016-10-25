//
//  CategoryListVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 30/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "CategoryVC.h"
#import "SubcategoryCell.h"

#import "VenderListVC.h"
#import "MBProgressHUD.h"
#import "TLYShyNavBar.h"
#import "Serverhit.h"
#import "AppDelegate.h"



@interface CategoryVC ()<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *categorytable;
    
    
}
@property(nonatomic,strong) NSArray * categoryArr;

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  fetchcategory];
    
     [categorytable registerNib:[UINib nibWithNibName:@"SubcategoryCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.categoryArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubcategoryCell  * cell = (SubcategoryCell*)[categorytable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"SubcategoryCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.subname.text= [self.categoryArr objectAtIndex:indexPath.row];
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *categoaryname= [self.categoryArr objectAtIndex:indexPath.row];

    
    [self.categoydelegate selectcategory:categoaryname];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)fetchcategory{
    
    
    if ([AppDelegate getDelegate].connected) {
        
        
        
    NSString *urlString =@"http://stg.qykly.mobi/v2/Category/";
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        Serverhit * obj=[[ Serverhit alloc]init];
        [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.categoryArr=[ dictResponse valueForKey:@"data"];
            // NSDictionary * tem
            if (self.categoryArr.count==0) {
                
            }
            else{
                
                
                [categorytable reloadData];
                
            }
            
        }];
    }
    else{
        
        
    }
    
    
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


@end
