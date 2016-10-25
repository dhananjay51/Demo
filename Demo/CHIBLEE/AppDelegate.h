//
//  AppDelegate.h
//  CHIBLEE
//
//  Created by Shailendra Pandey on 12/5/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property  BOOL CheckingComment;



@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *strForgot;
@property (strong, nonatomic) NSMutableArray *favoritevendor;
@property (strong, nonatomic) NSString *strAddress;
@property (nonatomic,strong)  NSString *location;

@property(nonatomic,strong) NSString *commentcount;
@property(nonatomic,strong) NSArray * commmentArr;
@property(nonatomic,strong) NSMutableArray *subcategoryArr;
@property(nonatomic,strong) NSString *pushToken;
@property(nonatomic,strong)  NSString * selectArea;
@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,strong) NSString *category;



+(AppDelegate*)getDelegate;
-(BOOL)connected;

@end

