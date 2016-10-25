//
//  ViewController.m
//  ASJTagsViewExample
//
//  Created by sudeep on 11/05/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "ViewController.h"
#import "ASJTagsView.h"
#import "CategorylistVC.h"
#import "AppDelegate.h"
#import <Reachability/Reachability.h>
#import "ServiceHIt.h"
#import "defineAllURL.h"
#import <SVProgressHUD/SVProgressHUD.h>



#import "AnalyticsHelper.h"
#import "MBProgressHUD.h"
#import "Serverhit.h"

@interface ViewController () <UITextFieldDelegate>
{
    NSMutableArray* searcharr;
    
    NSMutableArray *fecthdata;
    NSString *searchtext;
    
    
}

@property (weak, nonatomic) IBOutlet ASJTagsView *tagsView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

- (void)setup;
- (void)handleTagBlocks;
- (void)showAlertMessage:(NSString *)message;
- (IBAction)addTapped:(id)sender;
- (IBAction)clearAllTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
    
     [self.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
  [self setup];
}

#pragma mark - Setup

- (void)setup
{
  _tagsView.tagColorTheme = TagColorThemeStrawberry;
  [self handleTagBlocks];
  [_inputTextField becomeFirstResponder];
}

#pragma mark - Tag blocks

- (void)handleTagBlocks
{
  __weak typeof(self) weakSelf = self;
  [_tagsView setTapBlock:^(NSString *tagText, NSInteger idx)
   {
    // NSString *message = [NSString stringWithFormat:@"You tapped: %@", tagText];
    // [weakSelf showAlertMessage:message];
   }];
  
  [_tagsView setDeleteBlock:^(NSString *tagText, NSInteger idx)
   {
    // NSString *message = [NSString stringWithFormat:@"You deleted: %@", tagText];
     //[weakSelf showAlertMessage:message];
       
     [weakSelf.tagsView deleteTagAtIndex:idx];
   }];
}

- (void)showAlertMessage:(NSString *)message
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tap!" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [alert addAction:action];
  
  [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)addTapped:(id)sender
{
    
  [_tagsView addTag:_inputTextField.text];
  _inputTextField.text = nil;
}

- (IBAction)clearAllTapped:(id)sender
{
  [_tagsView deleteAllTags];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
   // [self addTapped:nil];
  return [textField resignFirstResponder];
}
#pragma mark
#pragma mark SearchWebservice
#pragma mark



#pragma mark Search friend
-(void)textFieldDidChange:(UITextField*)textField
{
    searchtext = textField.text;
    [self updateSearchArray];
}
//update seach method where the textfield acts as seach bar
-(void)updateSearchArray
{
    
    if (searchtext.length==0) {
        
    }
    else{
    [self search:searchtext];
    
    
    }
    
    
}




-(void)search:(NSString*)text
{
    
    if ([[AppDelegate getDelegate] connected]) {
        
        NSString * elasticsearch =  Baseurl @"getsuggestion/";
        
        NSString *urlString =[NSString stringWithFormat:@"%@"@"%@",elasticsearch,text];
        
        
        
        if ([AppDelegate getDelegate].connected) {
            
            
            NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            Serverhit * obj=[[ Serverhit alloc]init];
            [obj  Serverhit:encoded :^(NSDictionary *dictResponse) {
                NSLog(@"%@",dictResponse);
                fecthdata=[ dictResponse valueForKey:@"data"];
                
                
                if (fecthdata .count==0) {
                    
                
                    
                    
                }
                else{
                    [ _inputTextField resignFirstResponder];
                    
                    searcharr = [NSMutableArray array];
                   
                    for ( NSDictionary* item in fecthdata ) {
                        if ([[[item objectForKey:@"tags"] lowercaseString] rangeOfString:[searchtext lowercaseString]].location != NSNotFound) {
                            [searcharr addObject:item];
                            
                            
                            
                            
                        }
                    }
                    [_tagsView addTag:searcharr];
                    
                    
                }
                
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }];
        }
        
        else{
            
                    }
        
    }
    
}

@end
