//
//  SubcategoryVC.h
//  CHIBLEE
//
//  Created by Macbook Pro on 05/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol subcategoryDelegate <NSObject>
- (void)selectsubcategory:(NSString*)category;
@end

@interface SubcategoryVC : UIViewController
{
    IBOutlet UITableView *subcategorytable;
    IBOutlet UIView *locationview;
    IBOutlet   UILabel  *currentlocation;
}
@property(nonatomic,strong) NSArray * subcategoryArr;
@property(nonatomic,strong) NSString *imagename;
@property(nonatomic,strong) NSString *categoryname;
@property (nonatomic, strong) id <subcategoryDelegate>subcategorydelegate;
@property(nonatomic,strong) NSString *Vendor;

@end
