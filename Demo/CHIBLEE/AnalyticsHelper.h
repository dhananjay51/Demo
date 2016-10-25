//
//  GAHelper.h
//  YikYak
//
//  Created by Rahul Kumar on 2015-09-17.
//  Copyright (c) 2015 Kanwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Google/Analytics.h"
 
@interface AnalyticsHelper : NSObject

+ (void)trackScreen:(NSString *)screenName;
+ (void)trackEvent:(NSString *)category withAction:(NSString *)action andLabel:(NSString *)label;

@end
