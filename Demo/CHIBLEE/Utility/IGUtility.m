//
//  IGUtility.m
//  IGAttendance
//
//  Created by Kailash on 2/23/15.
//  Copyright (c) 2015 TTN Digital. All rights reserved.
//

#import "IGUtility.h"
//#import "IGReachability.h"
#import <UIKit/UIKit.h>
//#import "Reachability.h"

@implementation IGUtility

+(BOOL)checkNetworkConnection
{
   /* IGReachability *networkReachability = [IGReachability reachabilityForInternetConnection];
    //Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }*/
    return YES;
}

+(void)fireNotification
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [components setHour:9];
    // Gives us today's date but at 9am
    NSDate *next9am = [calendar dateFromComponents:components];
    if ([next9am timeIntervalSinceNow] < 0) {
        // If today's 9am already occurred, add 24hours to get to tomorrow's
        next9am = [next9am dateByAddingTimeInterval:60*60*24];
    }
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = next9am;
    notification.alertBody = @"It's been 24 hours.";
    // Set a repeat interval to daily
    notification.repeatInterval = NSDayCalendarUnit;
    //[[UIApplication sharedApplication] scheduleLocalNotification:notification];
}



@end
