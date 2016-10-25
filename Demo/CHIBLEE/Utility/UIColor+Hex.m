//
//  UIColor+Hex.m
//  YikYak
//
//  Created by Rahul Kumar on 2015-10-27.
//  Copyright © 2015 Kanwal. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColorAndHex

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
