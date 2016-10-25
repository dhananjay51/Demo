//
//  ShareVC.h
//  CHIBLEE
//
//  Created by Abhishek Srivastava on 02/05/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
@interface ShareVC : UIViewController<UITableViewDelegate, UITableViewDataSource,MFMessageComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate,MFMailComposeViewControllerDelegate>
{
    IBOutlet UITableView *table;
}
@property(nonatomic,strong)  SLComposeViewController *mySLComposerSheet;
@property(nonatomic,strong) IBOutlet UIBarButtonItem *sidebarButton;
@end
