//
//  SearchAreaVC.h
//  CHIBLEE
//
//  Created by Abhishek Srivastava on 23/04/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol searchDelegate <NSObject>
- (void)sendDataBacktoController:(NSDictionary*)area;
@end
@interface SearchAreaVC : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchDisplayDelegate>
{
   
    NSArray *searchResults;
    IBOutlet UITableView*datatable;
}
@property (nonatomic, strong) NSMutableArray *searchResult;
@property (nonatomic, strong) id <searchDelegate> searchdelegate;

@property (nonatomic, strong)IBOutlet UISearchBar*searchingbar;


@end
