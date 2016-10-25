//
//  ReviewCell.h
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *vendername;
@property(nonatomic,strong) IBOutlet UILabel *Address;

@property(nonatomic,strong) IBOutlet UILabel *Area;
@property(nonatomic,strong) IBOutlet UILabel *Rating;
@property(nonatomic, strong) IBOutlet UILabel *time;
@property(nonatomic,strong) IBOutlet UILabel *commentetx;



@end
