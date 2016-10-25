//
//  EarnrewardVC.m
//  
//
//  Created by Shailendra Pandey on 1/7/16.
//
//

#import "EarnrewardVC.h"

#import "TPKeyboardAvoidingScrollView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "AppDelegate.h"

#import <Google/Analytics.h>
#import <Crashlytics/Crashlytics.h>
#import "AnalyticsHelper.h"
//#import <AppsFlyer-SDK/AppsFlyerTracker.h>
#import "MBProgressHUD.h"
#import <Reachability/Reachability.h>
#import "DBManager.h"
#import "CategoryVC.h"
#import "SubcategoryVC.h"
#import "SearchAreaVC.h"
#import <Toast/UIView+Toast.h>
#import "UITextView+Placeholder.h"
#import "Serverhit.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "defineAllURL.h"
#import <Toast/UIView+Toast.h>
#define kOFFSET_FOR_KEYBOARD 80.0



@interface EarnrewardVC ()<NSURLConnectionDelegate,categoryDelegate,subcategoryDelegate,searchDelegate>
{
    NSString *imageString;
    NSString*home_deliveryStr;
    NSString *path;
    UIImage *chosenImage;
    NSMutableData*      mutableData;
    NSArray*arrayImages;
    BOOL  Chekingdatepicker;
    UIButton *SubmitButton;
    NSArray*array;
    NSArray*utilityarr ;
    NSArray*dailyarr ;
    NSArray*hobbyarr ;
    NSArray*foodarr ;
    NSArray*shoppingarr ;
    NSArray*miscarr ;
    NSArray*healtharr ;
    NSArray*owlarr ;
    NSArray*finalarr;
    IBOutlet UIView*blurview;
    BOOL multitime;
    BOOL  homedelivey;
    NSString * chekingstr;


    
}
@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation EarnrewardVC
@synthesize scroll;

#pragma mark ViewControllerLifeCycle

- (void)viewDidLoad {
   
    
    [super viewDidLoad];
    
     datatable.layer.cornerRadius = 5;
     datatable.layer.masksToBounds=YES;

      blurview.hidden=YES;
      datatable.hidden=YES;
    
    
    
      [datepckr setHidden:YES];
    
    [ self  addDoneToolBarToKeyboard: Remark_text];
   
    
    UIToolbar *tbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 56)];
    tbar.barStyle = UIBarStyleBlackOpaque;
    [tbar sizeToFit];
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    UIBarButtonItem *flexbtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [items addObject:flexbtn];
    
    UIBarButtonItem *donebtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Done)];
    [items addObject:donebtn];
    
    
    [tbar setItems:items];
    [datepckr addSubview: tbar];
    
    
    
    //[ opentime_text removeFromSuperview];
     opentime_text.inputAccessoryView=tbar;
   
     opentime_text.inputView = datepckr;
   
     //[ closetime_text removeFromSuperview];
     closetime_text.inputAccessoryView=tbar;
    
    closetime_text.inputView = datepckr;
   
    datepckr.backgroundColor = [UIColor whiteColor];
    


    
      Remark_text.placeholder=@" Write Here.......";
    

    
    
      self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"Chiblee.db"];

    
    SubmitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    SubmitButton.frame = CGRectMake(300, 0, 80, 40);
    [SubmitButton setTitle:@"DONE" forState:UIControlStateNormal];
     [SubmitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SubmitButton setTitleEdgeInsets: UIEdgeInsetsMake(-10,-15,-10,-40)];
   
    
    [SubmitButton addTarget:self action:@selector(SubmitVendorButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:SubmitButton];
    self.navigationItem.rightBarButtonItem = rightButton;

    datepckr.hidden=YES;
    
   
   AttachBTN.layer.cornerRadius = 5;
    AttachBTN.layer.masksToBounds=YES;

          UITapGestureRecognizer  *tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [scroll addGestureRecognizer:tapper];
    
    
    
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        //its iPhone. Find out which one?
        
        CGSize resultszie = [[UIScreen mainScreen] bounds].size;
        if(resultszie.height == 480)
        {
            // iPhone Classic
        }
        else if(resultszie.height == 568)
        { self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width , containerview.frame.size.height+320);
            
            // iPhone 5
        }
        else if(resultszie.height == 667)
        {
            self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width , self.scroll.frame.size.height+200);
            
            // iPhone 6
        }
        else if(resultszie.height == 736)
        {
            self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width , self.scroll.frame.size.height+130);
            // iPhone 6 Plus
        }
    }
     conatctview.hidden=YES;
     containerview.frame = CGRectMake(containerview.frame.origin.x, conatctview.frame.origin.y, containerview.frame.size.width, containerview.frame.size.height);
    seperatelabel.hidden=YES;

    
    
 //[ self.scroll contentSizeToFit];
    
    
    
     category_text.rightViewMode = UITextFieldViewModeAlways;
     category_text.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
     subcategory_text.rightViewMode = UITextFieldViewModeAlways;
    subcategory_text.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
   
     area_text.rightViewMode = UITextFieldViewModeAlways;

    area_text.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    
    
}

-(void)Done{
    
    datepckr.hidden=YES;
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
 //   [self.view endEditing:YES];
    datatable.hidden=YES;
    blurview.hidden=YES;
    scroll.scrollEnabled=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ActionButton Method

-(IBAction)Homedelivery:(UIButton*)sender
{
    if (sender.tag==100) {
       
         [sender setSelected: YES];
          homedeliveryYes.selected=YES;
          home_deliveryStr=@"YES";
         homedeliveryNo.selected =NO;
        homedelivey=YES;
        
            
        }
        
    
     else{
        
         homedeliveryNo.selected=YES;
         homedeliveryYes.selected=NO;
         home_deliveryStr=@"NO";
         homedelivey=NO;
         
            
    }

}


- (IBAction)multitimingBTN:(id)sender{
    if ([sender isSelected]) {
        [sender setSelected: NO];
        multitime=NO;
        
    } else {
        [sender setSelected: YES];
         multitime=YES;
       
    }
    
}

- (IBAction)Attechfie:(id)sender {
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
    }
    
    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
        
        chosenImage = info[UIImagePickerControllerEditedImage];
        
        VendorTakeimage.image=chosenImage;
        [picker dismissViewControllerAnimated:YES completion:NULL];
        VendorTakeimage.layer.masksToBounds = YES;
        VendorTakeimage .layer.cornerRadius = VendorTakeimage.frame.size.width/2;
        NSData *imageData = UIImageJPEGRepresentation(chosenImage, .7);
        NSLog(@"size: %lu",(unsigned long)imageData.length);
        
           }


    
- (void)SubmitVendorButton:(id)sender{
    
    
    
  
     if ([name_text.text length]==0)
    {
        
        [self Message:@"Please Enter Vendor Name"];
        
    }
    
    if ([contactNo_text.text length]==0)
    {   [self  Message:@"Please Enter Contact Number"];
        
        
    }
    
    
    
    else if ([category_text.text length]==0)
    {
        [self Message:@" Please Select Category"];

 
    }
    
     else if (subcategory_text.text.length==0)
     {
         
     }
    
   else if ([area_text.text length]==0) {
      
       [self Message:@"Plese Select Area"];
   }
   
   else if ([address_text.text length]==0)
       
   {         [self Message:@" Please Select ShopeNo"];
       
       
   }

    else if ([Landmarks_text.text length]==0)
    {
        [self Message:@"Please Select Landmark"];

        
    }
     else if ([opentime_text.text length]==0&&[closetime_text.text length]==0)
    {
        [self Message:@" please Select Open and CloseTime"];

        
    }

     else if (home_deliveryStr. length==0)
     {          [self Message:@"Please Select HomeDelivery"];
         
     }
     else if (Remark_text.text. length==0)
     {          [self Message:@"Please Type Remark"];
         
     }
    

    
    else{
    
        [self submit_vendor:nil];
    }

    
}
-(IBAction)submit_vendor:(id)sender
{

    
   
       if([[AppDelegate getDelegate] connected]) {
           
     
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        [reachability startNotifier];
        
        NetworkStatus status = [reachability currentReachabilityStatus];
        
        if(status == NotReachable)
        {
           [self savecora_data];
        }
        else if (status == ReachableViaWiFi)
        {
           [self uoplaod:nil];
        }
        else if (status == ReachableViaWWAN)
        {
            [ self savecora_data];
            //3G
        }
      
    }
    else{
        //[ self savecora_data];
    }
    
        
    
}


-(IBAction)dateChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *currentTime = [dateFormatter stringFromDate:datepckr.date];
    
    if (Chekingdatepicker==YES) {
        
        
        closetime_text.text = currentTime;
    }
    else{
        opentime_text.text = currentTime;
    }
    
       datepckr.hidden=YES;
}




-(void)insertDataWithID:(NSDictionary *)storedic {
    
    
     NSString *insertqueryy =   [NSString stringWithFormat: @"INSERT INTO Vendorinfo VALUES ('%@','%@',' %@','%@',' %@','%@',' %@','%@',' %@','%@','%@','%@')",[storedic valueForKey:@"address"],[storedic valueForKey:@"area"],[storedic valueForKey:@"name"],[storedic valueForKey:@"type"],[storedic valueForKey:@"contactno"],[storedic valueForKey:@"opentiming"],[storedic valueForKey:@"closetiming"],[storedic valueForKey:@"homedelivery"],[storedic valueForKey:@"remark"],[storedic valueForKey:@"image"], [storedic valueForKey:@"Lat"],[storedic valueForKey:@"Long"]];
    
    
    
    
    // Get the results.
    
    // Get the results.
    
    /// [self.dbManager loadDataFromDB:insertqueryy] ;
    
    [self.dbManager executeQuery:insertqueryy];
    ///  NSLog(@"%@", datafrom);
    
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
            }
    else{
        NSLog(@"Could not execute the query.");
    }
    
}

-(void)savecora_data {
    
    
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
     NSString *lat = [prefs stringForKey:@"latitude"];
     NSString *lon = [prefs stringForKey:@"longitude"];

     NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
     NSLog(@"size: %lu",(unsigned long)imageData.length);
    
      NSMutableDictionary * storeDict=[[ NSMutableDictionary alloc]init];
     [storeDict setValue:address_text.text forKey:@"address"];
     [storeDict setValue:area_text.text forKey:@"area"];
     [storeDict setValue:name_text.text forKey:@"name"];
     [ storeDict setValue:category_text.text forKey:@"type"];
     [ storeDict setValue:contactNo_text.text forKey:@"contactno"];
     [ storeDict setValue:opentime_text.text forKey:@"opentiming"];
     [ storeDict setValue:closetime_text.text forKey:@"closetiming"];
     [ storeDict setValue:home_deliveryStr forKey:@"homedelivery"];
     [ storeDict setValue:Remark_text.text forKey:@"remark"];
     [ storeDict setValue: imageData forKey:@"image"];
     [ storeDict setValue:lat forKey:@"Lat"];
     [ storeDict setValue:lon forKey:@"Long"];
     [ self insertDataWithID: storeDict];
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    
    return YES; // We do not want UITextField to insert line-breaks.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
       
    
    if (textField.tag==200) {
        [self.view endEditing:YES];
        
         [datepckr setHidden:NO];
         Chekingdatepicker=NO;
        //[self.view endEditing:YES];
    }

     else if (textField.tag==201) {
         
         
          [self.view endEditing:YES];
          [datepckr setHidden:NO];
           Chekingdatepicker=YES;
        
       
        
   
    }
     else{
         
     }

    
   
    

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
    Remark_text = textView;
}

-(void)doneButtonClickedDismissKeyboard
{
    [Remark_text resignFirstResponder];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [finalarr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //cell.textLabel.text =// [finalarr objectAtIndex:indexPath.row];
    
    if([chekingstr isEqualToString:@"Category"]) {
        NSString*catstring=[finalarr objectAtIndex:indexPath.row];
         cell.textLabel.text =catstring;
        
    }
    else if ([chekingstr isEqualToString:@"subcat"])
    {
        NSDictionary * temp=[ finalarr  objectAtIndex: indexPath.row];
        NSString * name=[ temp valueForKey:@"name"];
         cell.textLabel.text =name;
    }
    
    else{
        NSDictionary * temp=[ finalarr  objectAtIndex: indexPath.row];
        NSString * area=[ temp valueForKey:@"area"];
        cell.textLabel.text=area;
    }
    
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([chekingstr isEqualToString:@"Category"]) {
        NSString*catstring=[finalarr objectAtIndex:indexPath.row];
        category_text.text=catstring;
 
    }
    else if ([chekingstr isEqualToString:@"subcat"])
    {
        NSDictionary * temp=[ finalarr  objectAtIndex: indexPath.row];
        NSString * name=[ temp valueForKey:@"name"];
        subcategory_text.text=name;
    }
    
    else{
        NSDictionary * temp=[ finalarr  objectAtIndex: indexPath.row];
        NSString * area=[ temp valueForKey:@"area"];
        area_text.text=area;
    }
    
      datatable.hidden=YES;
      blurview.hidden=YES;
     scroll.scrollEnabled=YES;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
    datatable.hidden=YES;
    blurview.hidden=YES;
    scroll.scrollEnabled=YES;
}
- (void)selectcategory:(NSString*)category{

    category_text.text=category;
    
}
-(void)selectsubcategory:(NSString *)category{
    subcategory_text.text=category;
}
-(void)sendDataBacktoController:(NSDictionary *)area{
    
    
   NSString* areaname= [area valueForKey:@"area"];
    area_text.text=areaname;
}

-(void)Message:(NSString*)mess{
    // Make toast with a duration and position
    [self.navigationController.view makeToast:mess
                                     duration:1.0
                                     position:CSToastPositionBottom];
    
    
}
-(IBAction)opencontactview:(UIButton*)sender{
    
    if (sender.selected==YES)
    {
        sender.selected=NO;
        conatctview.hidden=YES;
        seperatelabel.hidden=YES;

        containerview.frame = CGRectMake(containerview.frame.origin.x, conatctview.frame.origin.y, containerview.frame.size.width, containerview.frame.size.height);
        

    }
    
    else{
        sender.selected=YES;
        conatctview.hidden=NO;
        seperatelabel.hidden=NO;

        
        containerview.frame = CGRectMake(containerview.frame.origin.x, 348, containerview.frame.size.width, containerview.frame.size.height);
        

    }
    
}

-(void)uoplaod:(NSString*)postdata{
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *lat = [prefs stringForKey:@"latitude"];
    NSString *lon = [prefs stringForKey:@"longitude"];
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    NSString * auth=[ prefs1 valueForKey:@"Auth"];

    
    NSMutableDictionary *_params=[[ NSMutableDictionary alloc]init];
    [_params setObject:@"0" forKey:@"latitude"];
    [_params setObject:@"0" forKey:@"longitude"];
    
    NSMutableArray *temparr=[[ NSMutableArray alloc]init];
    
    if (contactNo_text.text.length>0) {
     [temparr addObject:contactNo_text.text];
        
    }
    if (contactNo2_text.text.length>0) {
        [temparr addObject:contactNo2_text.text];

    }
    
    
    NSString *finalcontact = [temparr componentsJoinedByString:@","];
    NSLog(@"%@",finalcontact);

    
    [_params setObject:name_text.text forKey:@"name"];
    [_params setObject:finalcontact forKey:@"contact"];
    [_params setObject:category_text.text forKey:@"category"];
    [_params setObject:subcategory_text.text forKey:@"subCategory"];
    [_params setObject:area_text.text forKey:@"area"];
    [_params setObject:address_text.text forKey:@"shopNo"];
    [_params setObject:Landmarks_text.text forKey:@"landmark"];
    [_params setObject:[NSNumber numberWithBool:multitime]forKey:@"multiTme"];
     [_params setObject:opentime_text.text forKey:@"openingTiming"];
    [_params setObject:closetime_text.text forKey:@"closingTiming"];
     [_params setObject:[NSNumber numberWithBool:homedelivey] forKey:@"homeDelivery"];
     [_params setObject:@""forKey:@"tags"];
    
     [_params setObject:Remark_text.text forKey:@"remarks"];
    
    
    
    
    
    if ([AppDelegate getDelegate].connected==YES) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        

    
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = [NSString stringWithString:@"----------V2ymHFg03ehbqgZCaKO6jy"];
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = [NSString stringWithString:@"file"];
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = [NSURL URLWithString: Baseurl @"addnewvendor?"];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    [request setValue:auth forHTTPHeaderField: @"Authorization"];
    
    // set Content-Type in HTTP header
     NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
     [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
     NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
     NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
     if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
         [body appendData:imageData];
         [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    
    
  
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSLog(@"%@", error);
        if(data.length > 0)
        {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSDictionary *dict=[NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableLeaves error:nil];
             NSLog(@"%@",dict);
            
}
        
         else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
        
    }
    else{
        [self Message:@"No Internet Connection"];
    }
   
    
}
-(IBAction)category:(UIButton*)sender{
    
    [self.view endEditing:YES];

    
        if ([AppDelegate getDelegate].connected) {
            
            
            
            NSString *urlString = Baseurl @"Category";
            
            NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            Serverhit * obj=[[ Serverhit alloc]init];
            [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                 finalarr=[ dictResponse valueForKey:@"data"];
                // NSDictionary * tem
                if (finalarr.count==0) {
                    
                }
                else{
                    datatable.hidden=NO;
                    blurview.hidden=NO;
                    chekingstr=@"Category";
                    
                    [datatable reloadData];
                    
                }
                
            }];
        }
        else{
            
            [self Message:@"No Internet Connection"];
        

            
        }
        
        
    }

    
    

-(IBAction)subcategory:(id)sender{
    
    
    [self.view endEditing:YES];
    if (category_text.text.length==0) {
        [self Message:@"Please select category"];
        return;
    }
    
    
    if ([AppDelegate getDelegate].connected) {
        
        
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@", Baseurl @"subcategory/",category_text.text];
        
        NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        Serverhit * obj=[[ Serverhit alloc]init];
        [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
             finalarr =[ dictResponse valueForKey:@"data"];
            
            if ( finalarr.count==0) {
                
            }
            else{
                chekingstr=@"subcat";
                datatable.hidden=NO;
                blurview.hidden=NO;
            
                
                [ datatable reloadData];
                
            }
            
        }];
    }
    else{
        [self Message:@"No Internet Connection"];
    

        
    }
    

    }

-(IBAction)selectarea:(id)sender{
    
    [self.view endEditing:YES];

           if ([[AppDelegate getDelegate] connected]) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            NSString *urlString =[   NSString stringWithFormat:Baseurl @"areas"];
            NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            Serverhit * obj=[[ Serverhit alloc]init];
            [ obj Serverhit: encoded:^(NSDictionary *dictResponse) {
                
                [MBProgressHUD  hideHUDForView:self.view animated:YES];
                finalarr=[dictResponse objectForKey:@"data"];
                chekingstr=@"";
                // paging =@"";
                datatable.hidden=NO;
                blurview.hidden=NO;
                scroll.scrollEnabled=NO;
               
                [datatable reloadData];
                
            }];
            
        }
        
        else{
            [self Message:@"No Internet Connection"];
        

            
                    }
        
    }


@end
