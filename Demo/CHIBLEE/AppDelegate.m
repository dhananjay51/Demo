//
//  AppDelegate.m
//  CHIBLEE
//
//  Created by Shailendra Pandey on 12/5/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "SVProgressHUD.h"
#import <Reachability/Reachability.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Google/Analytics.h>
#import "MoEngage.h"
#import <AppsFlyerTracker.h>
#import "Flurry.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


#import "Serverhit.h"
#define uSignInFb @"userSignInfb" //user sign in through facebook
#define uSignInGmail @"userSignInGmail"


@class FBLoginView;
//@import Firebase;
static NSString * const kClientID=@"876492931248-3tj519lrqq76hrgghqjl3c8u1pv3rlda.apps.googleusercontent.com";

//@"382224144485-pa6fn8i04k95eaksl7ldfh3g9h9do11k.apps.googleusercontent.com";
//@"1049468805549-jrpu0phds0e8s4a87eekakhqtt2skt4r.apps.googleusercontent.com";


@interface AppDelegate ()
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
    
    NSString *latitude;
    NSString *longitude;
}
@property (nonatomic, strong) CLGeocoder *myGeocoder;
@end

@implementation AppDelegate

#pragma mark AppLunchMethod

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
    
   [[GAI sharedInstance] trackerWithTrackingId:@"UA-64915534-2"];
    [GAI sharedInstance].trackUncaughtExceptions = YES;
     [Fabric with:@[CrashlyticsKit]];
   /* [AppsFlyerTracker sharedTracker].appsFlyerDevKey = @"a0f29275-0545-4f98-b541-0744d106d302";
    [AppsFlyerTracker sharedTracker].appleAppID = @"999885600";
   [Flurry startSession:@"F7P4NX7JQKP377BZTY9Y"];
    [GMSServices provideAPIKey:@"AIzaSyCxi9SjN-I-HC1Rlj8VFsFXHb3sktgTtsg"];
     */
     
     
     
    
    
  
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        
        
        
        
        view.backgroundColor= [UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
        [self.window.rootViewController.view addSubview:view];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
           }
    
    
    NSError* configureError;
   //[[EAGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    [GIDSignIn sharedInstance].clientID = kClientID;
    
      locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
     locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    
   
   
 
  return YES;
}



#pragma mark Facebook and GoogleSafariOpenDelegate

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    BOOL  fg = [[NSUserDefaults standardUserDefaults]
                boolForKey:uSignInGmail];
    if (fg==YES) {
        return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation];
        
        
    }
    
    else{
        return [[FBSDKApplicationDelegate sharedInstance]application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
}


#pragma mark Geocoder and UpdateLocation Delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
  
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        
        
        CLLocation *location = [locationManager location];
        
        
        CLLocationCoordinate2D coordinate = [location coordinate];
        
        
        
        latitude = [NSString stringWithFormat:@"%.12f", coordinate.latitude];
        longitude = [NSString stringWithFormat:@"%.12f", coordinate.longitude];
        
        
        CLLocation *location1 = [[CLLocation alloc]
                                initWithLatitude:latitude.floatValue
                                longitude:longitude.floatValue];
        
        self.myGeocoder = [[CLGeocoder alloc] init];
        
        [self.myGeocoder
         reverseGeocodeLocation:location1
         completionHandler:^(NSArray *placemarks, NSError *error) {
             if (error == nil &&
                 [placemarks count] > 0){
                      placemark = [placemarks lastObject];
                 NSString*    vendorLocation=[NSString stringWithFormat:@"%@ %@",
                                              placemark.locality,
                                              placemark.subLocality];
                 NSLog(@"%@",vendorLocation);
                 
                                
                 
             }
         }];

        
        
    }
    // Reverse Geocoding
       [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
             if (error == nil && [placemarks count] > 0) {
            
            placemark = [placemarks lastObject];

            NSString*locationstr=[NSString stringWithFormat:@"%@ %@",
                                  placemark.locality,
                                  placemark.subLocality  ];
            
            
             NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:locationstr forKey:@"location"];
            [prefs setObject:latitude forKey:@"latitude"];
            [prefs setObject:longitude forKey:@"longitude"];
            [prefs synchronize];
                 
                 
        }
        else {
            
            NSLog(@"%@", error.debugDescription);
            
        }
        
    } ];
    
    [ locationManager stopUpdatingLocation];
    
}

- (void)gpsManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
}

#pragma mark InternetConnectionMethod
+(AppDelegate*)getDelegate{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    
    if ( networkStatus) {
        NSLog(@"Device is  connected to the internet");
        //[SVProgressHUD showWithStatus:@" "];
        return YES;
    } else {
        NSLog(@"Device is not connected to the internet");
        [SVProgressHUD showWithStatus:@"Device is not connected to the interne"];
        [SVProgressHUD dismiss];
        return NO;
    }
}

#pragma mark Pushnotificationdelagetemethod

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    
    
    
    NSString *devToken = (NSString *)[[[[deviceToken description]
                                        stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                       stringByReplacingOccurrencesOfString:@">" withString:@""]
                                      stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    
    NSString* myNSStr = [[NSString alloc] initWithFormat:@"%@",devToken] ;
    
    NSString* localStr =[[NSString alloc] initWithString:myNSStr];
    
    
    localStr = [localStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    localStr = [localStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    localStr = [localStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    
     NSLog(@"Device Token data = %@",localStr);
    [AppDelegate getDelegate].pushToken= localStr;
    
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
   // [[MoEngage sharedInstance]didFailToRegisterForPush];
}


-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
   /// [[MoEngage sharedInstance]didRegisterForUserNotificationSettings:notificationSettings];
}

 #pragma mark AppdelagteMethod

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // [[MoEngage sharedInstance] stop:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   /// [[MoEngage sharedInstance]applicationBecameActiveinApplication:application];
  //  [[AppsFlyerTracker sharedTracker] trackAppLaunch];}
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // [[MoEngage sharedInstance]applicationTerminated:application];// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
