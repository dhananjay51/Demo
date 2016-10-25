//
//  VendorDeatilCell.h
//  CHIBLEE
//
//  Created by Macbook Pro on 15/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VendorDeatilCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *usernem;
@property(nonatomic, strong) IBOutlet UILabel * Commment;
@property(nonatomic, strong) IBOutlet UILabel * Time;
@property(nonatomic, strong) IBOutlet UILabel *  Rating;
@property (nonatomic ,strong) IBOutlet UIImageView *userimage;




@end
