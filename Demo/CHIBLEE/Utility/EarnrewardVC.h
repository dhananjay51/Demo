//
//  EarnrewardVC.h
//  
//
//  Created by Shailendra Pandey on 1/7/16.
//
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;
@interface EarnrewardVC : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    
    __weak IBOutlet UITextField *name_text;
    
    __weak IBOutlet UITextField *contactNo_text;
    
       __weak IBOutlet UITextField *category_text;
    
       __weak IBOutlet UITextField * subcategory_text;

    __weak IBOutlet UITextField *area_text;

    __weak IBOutlet UITextField *address_text;
    
    
    __weak IBOutlet UITextField *Landmarks_text;
    __weak IBOutlet UIButton *multitimingbtn;
       __weak IBOutlet UITextField *opentime_text;
    __weak IBOutlet UITextField *closetime_text;
    
    
    __weak IBOutlet UITextView *Remark_text;

    
    
    __weak IBOutlet UIButton*AttachBTN;
    
       IBOutlet UIDatePicker*datepckr;
    
     IBOutlet UIImageView *VendorTakeimage;
     IBOutlet UITableView*datatable;
    __weak IBOutlet UIButton *homedeliveryYes;
    __weak IBOutlet UIButton *homedeliveryNo;
    IBOutlet UIView *conatctview;
     IBOutlet UIView *containerview;
    IBOutlet UILabel *seperatelabel;
    IBOutlet UITextField *contactNo2_text;

    
}
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet NSString *categoryvalue;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scroll;

-(IBAction)Attechfie:(id)sender;
-(IBAction)opencontactview:(id)sender;


@end
