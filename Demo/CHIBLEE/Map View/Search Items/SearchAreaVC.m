//
//  SearchAreaVC.m
//  CHIBLEE
//
//  Created by Abhishek Srivastava on 23/04/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "SearchAreaVC.h"


#import "CategorylistVC.h"
#import "AppDelegate.h"
#import <Reachability/Reachability.h>

#import "defineAllURL.h"
#import <SVProgressHUD/SVProgressHUD.h>


#import "AnalyticsHelper.h"
#import "MBProgressHUD.h"
#import "Serverhit.h"
#import "VenderListVC.h"
#import <Toast/UIView+Toast.h>


@interface SearchAreaVC ()
{
    
    
    NSMutableArray*searcharr;
   }

@end

@implementation SearchAreaVC

- (void)viewDidLoad {
    [super viewDidLoad];
       self.title=@"Search Loaction";
   
    _searchingbar.showsCancelButton = YES;
       _searchingbar.backgroundColor=[ UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";

    _searchingbar.placeholder=@"Search area ";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
   // [ self search:nil];
    
     [super viewDidLoad];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark SearchWebservice
#pragma mark


/*(-(void)search:(NSString*)text
{
    
    if ([[AppDelegate getDelegate] connected]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       
         NSString *urlString =[   NSString stringWithFormat:Baseurl @"areas"];
         NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         
         Serverhit * obj=[[ Serverhit alloc]init];
         [ obj Serverhit: encoded:^(NSDictionary *dictResponse) {
         
         [MBProgressHUD  hideHUDForView:self.view animated:YES];
         searcharr=[dictResponse objectForKey:@"data"];
         
        // paging =@"";
         datatable.delegate=self;
         datatable.dataSource=self;
         [datatable reloadData];
        [[NSUserDefaults standardUserDefaults]  setBool:NO forKey:@"Check"];
            [[NSUserDefaults standardUserDefaults] synchronize];
         }];
              
         }
    
    else{
        
        [SVProgressHUD showErrorWithStatus:@"No Internet connection"];    }
    
}

 
#pragma mark
#pragma mark Table Delegate and Table Data  Source Method
#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    } else {
        return [ searcharr count];    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [datatable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString * areaname;
    NSDictionary *areadict;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
          areadict  = [searchResults objectAtIndex:indexPath.row];
    } else {
         areadict = [searcharr objectAtIndex:indexPath.row];
    }
     areaname=[ areadict valueForKey:@"area"];
    
   
    cell.textLabel.text=areaname;
    
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [ AnalyticsHelper trackEvent:@"Searched Vendor" withAction:@"TapAction" andLabel:@"Search Vendor"];
    
    
        NSDictionary *areadict;
    
    if  (tableView == self.searchDisplayController.searchResultsTableView) {
         areadict = [searchResults objectAtIndex:indexPath.row];
    }  else {
          areadict = [searcharr objectAtIndex:indexPath.row];
   
    }
  
    
  /// [ self SearchArealist:areadict];

    
}
*/
#pragma mark
#pragma mark SearchWebservice
#pragma mark


-(void)search:(NSString*)text
{
    
    if ([[AppDelegate getDelegate] connected]) {
        
        NSString * elasticsearch =  Baseurl @"areas?";
        
        NSString *urlString =[NSString stringWithFormat:@"%@text=%@",elasticsearch,text];
        
    
        
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
    
    return searcharr.count;
    
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
    
    NSString * item=[ tmpdict valueForKey:@"area"];
    
    cell.textLabel.text=item;
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath {
    
    
    
    
    
    
     NSDictionary * tmpdict=[searcharr objectAtIndex:indexPath.row];
    
    //NSString * item=[ tmpdict valueForKey:@"tags"];
    
    
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
        [ self search:searchText];
    }
    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"Cancel clicked");
    
    [  searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    
}



/*

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"area contains[c] %@", searchText];
    searchResults = [searcharr filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
   
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

 */
-(void)SearchArealist:(NSDictionary*)areadict{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
       NSString * area=[ areadict valueForKey:@"area"];
            [prefs setObject:area forKey:@"location"];
       NSString * latitude=[ areadict valueForKey:@"latitude"];
       NSString *longitude=[areadict valueForKey:@"longitude"];
    
       [prefs setObject:latitude forKey:@"latitude"];
      [prefs setObject:longitude forKey:@"longitude"];
       [prefs synchronize];

    
    
            [self.searchdelegate sendDataBacktoController:areadict];
            
            [self.navigationController popViewControllerAnimated:YES];

            
    
}

@end
