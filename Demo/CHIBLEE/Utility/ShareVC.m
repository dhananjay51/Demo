//
//  ShareVC.m
//  CHIBLEE
//
//  Created by Abhishek Srivastava on 02/05/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import "ShareVC.h"
#import "CustomCell.h"
#import "SWRevealViewController.h"

@interface ShareVC ()
{
    NSMutableArray *sharearr;
    NSMutableArray *shareimg;
}
@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sharearr=[[NSMutableArray alloc]init];
    shareimg=[[ NSMutableArray alloc]init];
    [ sharearr addObject:@"Facebook"];
      [ sharearr addObject:@"Twiiter"];
      [ sharearr addObject:@"SMS"];
      [ sharearr addObject:@"Email"];
    [ sharearr addObject:@"More"];
    [shareimg addObject:@"facebook.png"];
      [shareimg addObject:@"Twitter.png"];
      [shareimg addObject:@"sms.png"];
      [shareimg addObject:@"mail.png"];
    [ shareimg addObject:@"more.png"];
    
   
    
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    
    // [UIColor colorWithRed:30/255.f green:160/255.f blue:67/255.f alpha:1]];
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
      
       [table registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ sharearr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = (CustomCell *)[table dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *nib;
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
   
    
    cell.sharename.text=[ sharearr objectAtIndex: indexPath.row];
      NSString *img=[ shareimg  objectAtIndex: indexPath.row ];
    cell.shareiconimage.image=[  UIImage imageNamed: img];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row==0) {
        [ self Facebook];
    }
    else if ( indexPath.row==1){
        [ self Twitter];
    }
    else if (indexPath.row==2){
        [ self Sms];
    }
    else if (indexPath.row==3){
        [ self Mail];
    }
    else{
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
-(IBAction)CancelClikcedBtn:(id)sender{
    [ self dismissViewControllerAnimated:YES completion:nil];
}


-(void) WhatApp{
    
    
    
    NSString * msg =  @"Chiblee";
    if (msg !=nil) {
        
        
      //  [[WASWhatsAppUtil getInstance] sendImage: imgshow.image inView:self.view];
        
       // [[WASWhatsAppUtil getInstance] sendText:yakTextLabel.text];
        
        
    }
    else{
        //[[WASWhatsAppUtil getInstance] sendImage: imgshow.image inView:self.view];
    }
    
    
}
-(void)Facebook
{
    
    if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Facebook!" message:@"Please login to Facebook in your device settings." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    // Facebook may not be available but the SLComposeViewController will handle the error for us.
    self.mySLComposerSheet = [[SLComposeViewController alloc] init];
    self.mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    //[_mySLComposerSheet setInitialText: yakTextLabel.tex];
    //NSString * finalImage;
  //  [self.mySLComposerSheet addImage:imgshow.image]; //an image you could post
    [self presentViewController:self.mySLComposerSheet animated:YES completion:nil];
    
    
    [self.mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
            {   output = @"Post successful.";
                
                
            }
                break;
            default:
                break;
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        // [alert show];
        //}
    }];
    
    
    
}


-(void) Twitter{
    
    
    if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        
    {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Twitter!" message:@"Please login to Twitter in your device settings." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    // Facebook may not be available but the SLComposeViewController will handle the error for us.
    //  self.mySLComposerSheet = [[SLComposeViewController alloc] init];
    self.mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
  ///  [self.mySLComposerSheet addImage:imgshow.image]; //an image you could post
    [self presentViewController:self.mySLComposerSheet animated:YES completion:nil];
   // [_mySLComposerSheet setInitialText: yakTextLabel.text];
    
    [self.mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:{
                
                output = @"Post successful.";
                
            }
                break;
            default:
                break;
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
    }];
}


-(void) Mail{
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@" LoudShougt+"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"", nil];
        [mailer setToRecipients:toRecipients];
        
        
      ///  NSData *imageData = UIImagePNGRepresentation(imgshow.image);
      //  [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
      //  NSString *emailBody =  yakTextLabel.text;
      //  [mailer setMessageBody:emailBody isHTML:NO];
        
        [ self  presentViewController:mailer animated:YES completion: nil];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    
    
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [ self dismissViewControllerAnimated:YES completion:nil];
}
-(void)Instagram{
    
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if (![[UIApplication sharedApplication] canOpenURL:instagramURL]){
        
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't share a message on instagram right now, make sure your device has an internet connection and you have at least one instagram account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    else
    {
        //installed
        // [self performActivity];
      ///  [self performActivity : yakTextLabel.text : imgshow.image];
        
    }
    
    
}


/*- (void)performActivity :(NSString *) shareText :(UIImage *) shareImage{
    // no resize, just fire away.
    //UIImageWriteToSavedPhotosAlbum(item.image, nil, nil, nil);
    
    CGFloat cropVal = (shareImage.size.height > shareImage.size.width ? shareImage.size.width : shareImage.size.height);
    
    cropVal *= [shareImage scale];
    
    CGRect cropRect = (CGRect){.size.height = cropVal, .size.width = cropVal};
    CGImageRef imageRef = CGImageCreateWithImageInRect([shareImage CGImage], cropRect);
    
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:imageRef], 1.0);
    CGImageRelease(imageRef);
    
    NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
    if (![imageData writeToFile:writePath atomically:YES]) {
        // failure
        // NSLog(@"image save failed to path %@", writePath);
        return;
    } else {
        // success.
    }
    
    // send it to instagram.
    NSURL *fileURL = [NSURL fileURLWithPath:writePath];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.documentInteractionController.delegate = self;
    [self.documentInteractionController setUTI:@"com.instagram.exclusivegram"];
    if (shareText) [self.documentInteractionController setAnnotation:@{@"InstagramCaption" : shareText}];
    
    [self.documentInteractionController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
    
}
*/
-(void)Sms{
    
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    //NSArray *recipents = @[@""];
   NSString *message =@"";
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    // [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*-(void)iMessage{
    
    
    MFMessageComposeViewController* composer = [[MFMessageComposeViewController alloc] init];
    composer.messageComposeDelegate = self;
    [composer setSubject:@"Chiblee"];
    
    
    if([MFMessageComposeViewController respondsToSelector:@selector(canSendAttachments)] && [MFMessageComposeViewController canSendAttachments])
    {
        NSData* attachment = UIImageJPEGRepresentation(imgshow.image, 1.0);
        
        NSString* uti = (NSString*)kUTTypeMessage;
        [composer addAttachmentData:attachment typeIdentifier:uti filename:@"filename.jpg"];
    }
    NSMutableString *emailBody = [[NSMutableString alloc] initWithString:yakTextLabel.text];
    composer.messageComposeDelegate = self;
    composer.body = emailBody;
    
    [self presentViewController:composer animated:YES completion:nil];
    
}
*/

@end
