//
//  EditProfileVC.m
//  CHIBLEE
//
//  Created by Macbook Pro on 29/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "EditProfileVC.h"

@interface EditProfileVC ()

@end

@implementation EditProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *namestr = [defaults objectForKey:@"userName"];
    NSString *imgstr = [defaults objectForKey:@"userImg"];
    
    NSString *logged = [defaults objectForKey:@"profileType"];
    
    
    
    self.username.text=namestr;
    
    self.logged.text=[ NSString stringWithFormat:@"%@" @"%@" @"%@",[logged uppercaseString],@"LOGGED",@"IN"];
    
    NSURL* url = [NSURL URLWithString:imgstr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   self.userimage.image = [UIImage imageWithData:data];
                               }
                               
                           }];
    self.userimage.layer.cornerRadius = self.userimage.frame.size.height/2;
    self.userimage.clipsToBounds = YES;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
