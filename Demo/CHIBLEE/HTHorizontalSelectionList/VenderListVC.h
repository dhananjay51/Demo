//
//  VenderListVC.h
//  CHIBLEE
//
//  Created by Macbook Pro on 07/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;
@interface VenderListVC : UIViewController{
    IBOutlet TPKeyboardAvoidingScrollView *scrollView;
    IBOutlet UITableView *Vendorlisttable;
    IBOutlet UILabel * currentlocation;
    IBOutlet UIView *locationview;
    IBOutlet UIView *filterview;
    
    IBOutlet UIView *blureview;
    IBOutlet UIView *popview;
    IBOutlet UIView *alertView;
    IBOutlet  UITextView  *Commenttxt;
    IBOutlet UISlider *slidervalue;
    IBOutlet UILabel * sliderlabel;
    IBOutlet  UIImageView *blureimage;
    
}
@property(nonatomic,strong) NSMutableArray * VendorlistArr;
@property(nonatomic,strong) NSString *Categoryname;
@property(nonatomic,strong) NSString *subcategoryname;
@property(nonatomic,strong) NSDictionary * elasticdict;
@property(nonatomic,strong)  IBOutlet UILabel * homedliveylabel;
@property(nonatomic,strong) IBOutlet UIImageView * homedeliveryicon;

@end
