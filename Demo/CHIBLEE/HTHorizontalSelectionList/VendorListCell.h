//
//  VendorListCell.h
//  CHIBLEE
//
//  Created by Macbook Pro on 07/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface VendorListCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *VendorName;
@property(nonatomic,strong) IBOutlet UILabel *VendorAddress;
@property(nonatomic,strong) IBOutlet UILabel *VendorArea;

@property(nonatomic,strong) IBOutlet UILabel *Shoptime;

@property(nonatomic,strong) IBOutlet UILabel *distance;
@property(nonatomic,strong) IBOutlet UILabel *homeDelivery;
@property(nonatomic,strong) IBOutlet UILabel *rating;

@property(nonatomic,strong) IBOutlet CustomButton *callingbtn;
@property(nonatomic,strong) IBOutlet CustomButton * commentngbtn;
@property(nonatomic,strong) IBOutlet CustomButton *bookmark;
@property(nonatomic,strong) IBOutlet  UIView * ratingview;
@property(nonatomic,strong)  IBOutlet UILabel * homedliveylabel;
@property(nonatomic,strong) IBOutlet UIImageView * homedeliveryicon;



@end
