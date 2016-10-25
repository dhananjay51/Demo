//
//  LoginVC.m
//  Chiblee
//
//  Created by Shailendra Pandey on 11/30/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import "LoginVC.h"
#import "CategorylistVC.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKLoginKit/FBSDKLoginButton.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "UIColor+Hex.h"
#import "fontello.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import "NSData+Base64.h"
#import "defineAllURL.h"
#import "AnalyticsHelper.h"
#import "MBProgressHUD.h"
#import "DBManager.h"
#import "Serverhit.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "AppDelegate.h"
#import<Toast/UIView+Toast.h>

@import Firebase;



#define uSignInFb @"userSignInfb" //user sign in through facebook
#define uSignInGmail @"userSignInGmail"
@interface LoginVC ()<GIDSignInDelegate, GIDSignInUIDelegate>
{
    NSMutableData * mutableData;
    
    NSString *email;
    NSString *name;
    NSString *idToken;
    NSString *userId;
    NSString * image;

    NSDictionary* fbname;
    NSDictionary* fbid;
    NSDictionary* fbemail;
    NSDictionary* fbimg;
    NSString *userImageURL;
    NSString*gmailimageurl;
    NSMutableDictionary *userDetaildict;
}


@end

@implementation LoginVC

#pragma mark View Controllerviewlife
- (void)viewDidLoad {
    [super viewDidLoad];
         self.navigationController.navigationBarHidden=YES;
//-------------------------Fontello Icon Image----------------------------------//
    [self.iconLabel setFont:[UIFont fontWithName:@"fontello" size:210]];
    [self.iconLabel  setText:MAIN_LOGO];
     self.iconLabel .textColor = [UIColorAndHex colorFromHexString:WhiteColour];
    
    [self.cbibleeIcon setFont:[UIFont fontWithName:@"fontello" size:71]];
    [self.cbibleeIcon  setText:LOGO_ICON];
    self.cbibleeIcon .textColor = [UIColorAndHex colorFromHexString:WhiteColour];
    [FBSDKAccessToken currentAccessToken];
    
  

     [GIDSignInButton class];
     GIDSignIn *signIn = [GIDSignIn sharedInstance];
     signIn.shouldFetchBasicProfile = YES;
     signIn.delegate = self;
    
     signIn.uiDelegate = self;
    userDetaildict=[[ NSMutableDictionary alloc]init];
    
    
    BOOL   check= [[NSUserDefaults standardUserDefaults]
                   boolForKey:@"isLogedin"];
    
    if (check==YES) {
       
        
        
   /// [self performSegueWithIdentifier:@"Login" sender:nil];
        
    }

    
    
}



-(void)viewWillAppear:(BOOL)animated{
    [AnalyticsHelper trackScreen:@"LoginScreen"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark-
#pragma mark facebook login

-(IBAction)login:( UIButton*)sender{
    
    if ([AppDelegate getDelegate].connected) {
        
    
    [ AnalyticsHelper trackEvent:@"Fblogin" withAction:@"TapAction" andLabel:@"Fblabel"];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    NSUserDefaults *userpref=[[NSUserDefaults alloc]init];

    [userpref setBool:NO forKey:uSignInGmail];
    
   [ userpref synchronize];
    
    [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        //  [ self getFacebookProfileInfos];
        if (error)
        {
            
            // There is an error here.
            
        }
        else
        {
            if(result.token)   // This means if There is current access token.
            {
                // Token created successfully and you are ready to get profile info
                /*
                
                FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                                 credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                                 .tokenString];
                
                [[FIRAuth auth] signInWithCredential:credential
                                          completion:^(FIRUser *user, NSError *error) {
                                              
                                              NSLog(@"%@", user.uid);
                                              NSLog(@"%@", error);
                                              
                                          }];
                 */
                [self getFacebookProfileInfos];
            }
        }
    }];
    }
    else{
        
    }
     // [self getFacebookProfileInfos];
}

-(void)getFacebookProfileInfos {
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters: @{@"fields": @"picture, email,name,first_name,last_name"}];
    
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         fbname =[result objectForKey:@"name"];
          fbid =[result objectForKey:@"id"];
         fbemail =[result objectForKey:@"email"];
         NSDictionary* pic =[result objectForKey:@"picture"];
       NSDictionary* data =[pic objectForKey:@"data"];
         fbimg =[data objectForKey:@"url"];
        userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", fbid];
        if (fbid==nil||fbname==nil) {
            
        }
        else{

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:fbname forKey:@"userName"];
        [defaults setObject:userImageURL forKey:@"userImg"];
        [defaults setObject:fbid forKey:@"userId"];
        [defaults setObject:fbemail forKey:@"userEmail"];
        [defaults setValue:@"Facebook" forKey:@"ProfileType"];

        [defaults synchronize];
        [userDetaildict setValue:fbname forKey:@"userName"];
        [userDetaildict setValue:fbemail forKey:@"userEmail"];
        [userDetaildict setValue:userImageURL forKey:@"userImg"];
        [userDetaildict setValue:@"Facebook" forKey:@"ProfileType"];
    
        if(result)
        {
            
            [ self LoginApi:userDetaildict];
           /* if ([result objectForKey:@"email"]) {
                
                NSLog(@"Email: %@",[result objectForKey:@"email"]);
                
            }
            if ([result objectForKey:@"first_name"]) {
                
                NSLog(@"First Name : %@",[result objectForKey:@"first_name"]);
                
            }
            if ([result objectForKey:@"id"]) {
                
                NSLog(@"User id : %@",[result objectForKey:@"id"]);
                
                //[self performSegueWithIdentifier:@"Login" sender:nil];
                
             
            }
            */
            }
        
            
            

        }
        
    }];
    
    [connection start];
  
    
}

#pragma mark-
#pragma mark Gmail login

-(IBAction)loginGmail:(id)sender{
    if ([AppDelegate getDelegate].connected) {
        
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     [ AnalyticsHelper trackEvent:@"Gmaillogin" withAction:@"TapAction" andLabel:@"Fblabel"];
   
    
    NSUserDefaults *userpref=[[NSUserDefaults alloc]init];
    [userpref setBool:YES forKey:uSignInGmail];//if user login with gmail/google+
    [ userpref synchronize];
    [[GIDSignIn sharedInstance] signIn];
    [_signInButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // [self performSegueWithIdentifier:@"Login" sender:nil];
    }
    else{
    
        
    }
   // [self performSegueWithIdentifier:@"Login" sender:nil];
}



- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
   // [myActivityIndicator stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
      presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    userId = user.userID;                  // For client-side use only!
    idToken = user.authentication.idToken; // Safe to send to the server
    name = user.profile.name;
    
    email = user.profile.email;
    NSURL *imgurl=   [[GIDSignIn sharedInstance].currentUser.profile imageURLWithDimension:0];
    gmailimageurl=[ imgurl absoluteString];
    if (userId==nil||name==nil) {
          [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name forKey:@"userName"];
    [defaults setObject:userId forKey:@"userId"];
    [defaults setObject:email forKey:@"userEmail"];
    [defaults setObject: gmailimageurl forKey:@"userImg"];
    [defaults setValue:@"Google" forKey:@"profileType"];
    [defaults synchronize];
 
    [userDetaildict setValue:name forKey:@"userName"];
    [userDetaildict setValue:email forKey:@"userEmail"];
    [userDetaildict setValue:gmailimageurl forKey:@"userImg"];
    [userDetaildict setValue:@"Google" forKey:@"profileType"];
        
    [self LoginApi:userDetaildict];
  
    }
    
    
    }

- (IBAction)didTapSignOut:(id)sender {
    
    [[GIDSignIn sharedInstance] signOut];
}
#pragma LoginApi
-(void)LoginApi:(NSDictionary*)userdetail{

    
    
    
    UIDevice *device = [UIDevice currentDevice];
    
    
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    NSLog(@"Carrier Name: %@", [carrier carrierName]);
    
    
    NSString * iosversion = [[UIDevice currentDevice] systemVersion];
    
    
      NSString *deviceType = [[UIDevice currentDevice] model];
    
    NSString * userName=[ userdetail valueForKey:@"userName"];
    NSString * userEmail=[ userdetail valueForKey:@"userEmail"];
    NSString * userImg=[ userdetail valueForKey:@"userImg"];
    NSString *type=[userdetail valueForKey:@"profileType"];
    NSMutableDictionary * tempdict =[[NSMutableDictionary alloc]init];
    
    [ tempdict setValue:userName forKey:@"name"];
    [ tempdict setValue:userEmail forKey:@"email"];
    [ tempdict setValue:userImg forKey:@"imageUrl"];
    [ tempdict setValue:@"iOS" forKey:@"platform"];
    [ tempdict setValue: iosversion forKey:@"appVersion"];
    [ tempdict setValue:[AppDelegate getDelegate].pushToken forKey:@"pushToken"];
    [ tempdict setValue:currentDeviceId forKey:@"deviceId"];
    [ tempdict setValue:deviceType forKey:@"model"];
    [ tempdict setValue: [carrier carrierName] forKey:@"sim"];
    [ tempdict setValue:type forKey:@"profileType"];
    
      NSString *urlString = [NSString stringWithFormat:Baseurl @"login"];
    if ([AppDelegate getDelegate].connected==YES) {

    
    Serverhit * obj=[[ Serverhit alloc]init];
    
    [obj  ServiceHitWithHttpString:tempdict :urlString :^(NSDictionary *dictResponse) {
        int code=[[ dictResponse valueForKey:@"error"] intValue];
        NSString * authtoken=[ dictResponse valueForKey:@"data"];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
     
        if (code==0) {
     
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:authtoken forKey:@"Auth"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogedin"];
          
             [prefs synchronize];
            
             [self performSegueWithIdentifier:@"Login" sender:nil];

        }
        
        else{
            
            
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
