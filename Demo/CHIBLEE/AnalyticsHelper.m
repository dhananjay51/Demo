//
//  GAHelper.m
//  YikYak
//
//  Created by Rahul Kumar on 2015-09-17.
//  Copyright (c) 2015 Kanwal. All rights reserved.
//

#import "AnalyticsHelper.h"
#import <AppsFlyerTracker.h>
#import "Flurry.h"


@implementation AnalyticsHelper

+ (void)trackScreen:(NSString *)screenName {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
  ///  [Apsalar event:screenName];
    
    }

+ (void)trackEvent:(NSString *)category withAction:(NSString *)action andLabel:(NSString *)label {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                         action:action
                                                          label:label
                                                           value:nil] build]];
    
      // [Apsalar eventWithArgs:category, @"Action", action, @"Label", label, nil];
    
        [[AppsFlyerTracker sharedTracker] trackEvent:action withValue:nil];
    
       [ Flurry  logEvent:@"Action"];
    
     // [FBSDKAppEvents logEvent:@"FBSDKAppEventNameActivatedApp"];
}


@end
