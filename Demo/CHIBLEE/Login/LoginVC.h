//
//  LoginVC.h
//  Chiblee
//
//  Created by Shailendra Pandey on 11/30/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>


@interface LoginVC : UIViewController
//----------------Fontello Icon------------------------------------------//
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *cbibleeIcon;



@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

@end
