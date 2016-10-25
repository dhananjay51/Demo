//
//  ActivityCell.h
//  CHIBLEE
//
//  Created by Shailendra Pandey on 1/12/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel*VendorName;
@property(nonatomic,strong) IBOutlet UILabel*vendorAddress;
@property(nonatomic,strong) IBOutlet UILabel*vendorTiming;
@property(nonatomic,strong) IBOutlet UILabel*vendorContact_no;
@property(nonatomic,strong) IBOutlet UILabel*vendorRemark;
@property(nonatomic,strong) IBOutlet UIImageView*VendorImage;
@property(nonatomic,strong) IBOutlet UILabel*pendinglabel;


@end
