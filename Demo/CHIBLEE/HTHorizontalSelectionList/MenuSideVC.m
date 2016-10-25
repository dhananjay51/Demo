//
//  MenuSideVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 02/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "MenuSideVC.h"
#import "SWRevealViewController.h"
#import "MenuCell.h"

@interface MenuSideVC ()<UITableViewDelegate, UITableViewDataSource>
{
    
        NSArray *menuarr;
         NSArray *imagearr;
    
}
@end

@implementation MenuSideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *namestr = [defaults objectForKey:@"userName"];
    NSString *imgstr = [defaults objectForKey:@"userImg"];
    NSString*emailstr=[defaults objectForKey:@"userEmail"];
    username.text=namestr;
     useremail.text=emailstr;
    NSURL* url = [NSURL URLWithString:imgstr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   userimage.image = [UIImage imageWithData:data];
                               }
                           }];
    

    
    menuarr=[ NSArray arrayWithObjects:@"Home",@"Added Vendors",@"Bookmark",@"Profile",@"About",@"Share App",nil];
    imagearr=[ NSArray arrayWithObjects:@"Home.png",@"addedvender.png",@"bookmarks.png",@"Profile.png",@"setting.png",@"share.png",nil];

    
    
    [sidemenutable registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    userimage.layer.cornerRadius = userimage.frame.size.height/2;
    userimage.clipsToBounds = YES;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:30.0f/255.0f green:160.0f/255.0f blue:67.0f/255.0f alpha:1.0f]];
    
   
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   

  
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return menuarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuCell  * cell = (MenuCell*)[sidemenutable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"SideCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name.text=[ menuarr objectAtIndex:indexPath.row];
    cell.image.image= [UIImage imageNamed:[imagearr objectAtIndex:indexPath.row]];
    
    //[ imagearr objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     SWRevealViewController *revealController = self.revealViewController;
    
    
    if (indexPath.row==0) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        UIViewController *rear=[storyboard instantiateViewControllerWithIdentifier:@"CategorylistVC"];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rear];
        
        [revealController pushFrontViewController:navigationController animated:YES];
        
    }
    
    
    
    else if (indexPath.row==1){
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        UIViewController *rear=[storyboard instantiateViewControllerWithIdentifier:@"AddVenderVC"];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rear];
        
         [revealController pushFrontViewController:navigationController animated:YES];
        
        
        
    }
     else if (indexPath.row==2){
         
         
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         
         
         
         UIViewController *rear=[storyboard instantiateViewControllerWithIdentifier:@"FAvvendorVC"];
         
         UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rear];
         
         [revealController pushFrontViewController:navigationController animated:YES];
         

            }
    
    
    else if (indexPath.row==3){
        
        
        
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        UIViewController *rear=[storyboard instantiateViewControllerWithIdentifier:@"ActivityVC"];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rear];
        
        [revealController pushFrontViewController:navigationController animated:YES];
        
        //[ self.navigationController popToRootViewControllerAnimated:YES];
        
        

        
    }
     else if (indexPath.row==4){
        
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        UIViewController *rear=[storyboard instantiateViewControllerWithIdentifier:@"SettingVC"];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rear];
        
        [revealController pushFrontViewController:navigationController animated:YES];
        
        //[ self.navigationController popToRootViewControllerAnimated:YES];
        

     }
     else{
         
     
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        UIViewController *rear=[storyboard instantiateViewControllerWithIdentifier:@"ShareVC"];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rear];
        
        [revealController pushFrontViewController:navigationController animated:YES];
        
    }
    
}
    
@end
