//
//  ContactedVC.h
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactedVC : UIViewController
@property(nonatomic,weak) IBOutlet UIImageView *userimage;
@property(nonatomic,weak) IBOutlet UILabel *username;
@property(nonatomic,weak) IBOutlet UILabel *userlocation;
@property(nonatomic,weak) IBOutlet UILabel *synctime;
@property(nonatomic,strong) IBOutlet UITableView *contactedtabel;
@property(nonatomic,weak) IBOutlet UIView * userview;
@property(nonatomic,strong) IBOutlet UILabel *Totalconatact;
@property (nonatomic, strong) UINavigationController *parentNavigationController;

@end
