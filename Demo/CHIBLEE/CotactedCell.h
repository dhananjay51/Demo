//
//  CotactedCell.h
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CotactedCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *vednername;
@property(nonatomic,strong) IBOutlet UILabel *area;
@property(nonatomic,strong) IBOutlet UILabel *address;
@property(nonatomic,strong)  IBOutlet UILabel *time;

@end
