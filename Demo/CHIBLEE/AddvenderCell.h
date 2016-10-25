//
//  AddvenderCell.h
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface AddvenderCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel* vendername;
@property(nonatomic,strong) IBOutlet UILabel *area;
@property(nonatomic,strong)IBOutlet UILabel *address;
@property(nonatomic,strong) IBOutlet UILabel *timing;
@property(nonatomic,strong) IBOutlet CustomButton * callingbtn;
@property(nonatomic,strong) IBOutlet CustomButton * Commnetbtn;
@property(nonatomic,strong) IBOutlet CustomButton * bookmarkbtn;
@property(nonatomic,strong) IBOutlet  CustomButton *deletebtn;
@property(nonatomic,strong) IBOutlet  UIView *containerview;
@property(nonatomic,strong) IBOutlet   UIImageView *Status;
@property(nonatomic,strong) IBOutlet    UILabel *distance;
@property(nonatomic,strong) IBOutlet    UILabel *ratiing;
@property(nonatomic,strong) IBOutlet UIImageView *ratingimg;
@property(nonatomic,strong) IBOutlet UILabel *homedelivery;


@end
