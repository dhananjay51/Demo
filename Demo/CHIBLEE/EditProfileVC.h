//
//  EditProfileVC.h
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileVC : UIViewController
@property(nonatomic,weak) IBOutlet UIImageView *userimage;
@property(nonatomic,weak) IBOutlet UITextField *username;
@property(nonatomic,weak) IBOutlet UITextField *mobilenumber;

@property(nonatomic,weak) IBOutlet UILabel  *logged;



@end
