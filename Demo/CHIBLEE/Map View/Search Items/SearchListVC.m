//
//  SearchListVC.m
//  Chiblee
//
//  Created by Shailendra Pandey on 11/30/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import "SearchListVC.h"
#import "SearchListCell.h"


#import "CategorylistVC.h"
#import "AppDelegate.h"
#import <Reachability/Reachability.h>
#import "ServiceHIt.h"
#import "defineAllURL.h"
#import <SVProgressHUD/SVProgressHUD.h>



#import "AnalyticsHelper.h"
#import "MBProgressHUD.h"
#import "Serverhit.h"
#import "VenderListVC.h"


@interface SearchListVC ()<UISearchBarDelegate>
{

    NSMutableData*mutableData;
    NSDictionary *result;
    NSArray *searchdata;
    NSArray*subcategoryArr;
    NSDictionary*errordict;
    NSMutableArray*searcharr;
    NSMutableArray*  array;
    NSArray * savesearcharr;
    BOOL check;
     NSMutableArray * itemarr;
     NSMutableDictionary *categorydict;
    NSMutableArray * SearchArr;
    
}
@end

@implementation SearchListVC
@synthesize tableData;
@synthesize searchResult;



#pragma mark
#pragma mark ViewControllerLifeCycle
#pragma mark

- (void)viewDidLoad {

    [super viewDidLoad];
   
    array=[[ NSMutableArray alloc]init];
    
      _searchingbar.backgroundColor=[ UIColor whiteColor];;
    self.searchingbar.delegate = self;
    
    self.navigationController.navigationBar.topItem.title = @"";
       _searchingbar.placeholder=@"Search";
 
        [super viewDidLoad];
    
    
  }
-(void)viewWillAppear:(BOOL)animated{
     savesearcharr= [[NSUserDefaults standardUserDefaults]
                    objectForKey:@"SearchData"];
    
    
        [ datatable reloadData];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark
#pragma mark SearchWebservice
#pragma mark


-(void)search:(NSString*)text
{
    SearchArr=[[ NSMutableArray alloc]init];
    
    if ([[AppDelegate getDelegate] connected]) {
        
       NSString * elasticsearch =  Baseurl @"getsuggestion/";
        
        NSString *urlString =[NSString stringWithFormat:@"%@"@"%@",elasticsearch,text];
        
    
        
        if ([AppDelegate getDelegate].connected) {
            
            
            NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            Serverhit * obj=[[ Serverhit alloc]init];
            [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
                NSLog(@"%@",dictResponse);
                searcharr=[ dictResponse valueForKey:@"data"];
                
                
                if (searcharr.count==0) {
                    
                    
                    
                    
                }
                else{
                    
                        datatable.dataSource=self;
                        datatable.delegate=self;
                        [datatable reloadData];
                    
                    }
                    
                    
                
                
                
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }];
        }
        
        else{
            
            [SVProgressHUD showErrorWithStatus:@"No Internet Connection"];
        }
        
    }
    
    }
    
        

#pragma mark
#pragma mark Table Delegate and Table Data  Source Method
#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return SearchArr.count;
    
}

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [datatable dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
     
        
        
        NSDictionary * tmpdict=[searcharr objectAtIndex:indexPath.row];
        
        NSString * item=[ tmpdict valueForKey:@"tags"];
        

        
        cell.textLabel.text=item;
    
        
        return cell;
    }

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath {
   
    
    
    
    
        
    NSDictionary * tmpdict=[searcharr objectAtIndex:indexPath.row];
    
    
    
    
     VenderListVC * vc=[self.storyboard  instantiateViewControllerWithIdentifier:@"VenderListVC"];
     vc.elasticdict= tmpdict;
    
    
    [ self.navigationController pushViewController:vc animated:YES];
    
    
        }
         




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
   // [searchBar resignFirstResponder];
   /// [[NSUserDefaults standardUserDefaults]  setBool:YES forKey:@"Check"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    if ([searchText isEqualToString:@""]) {
      //  [ searchBar resignFirstResponder];
        [ datatable reloadData];

    }
    else{
        
       [self search:searchText];
    }
    
   }


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
      NSLog(@"Cancel clicked");
   
    [  searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
     
       [searchBar resignFirstResponder];
   
     
 }
@end
