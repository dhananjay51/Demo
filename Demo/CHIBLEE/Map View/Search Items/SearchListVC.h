//
//  SearchListVC.h
//  Chiblee
//
//  Created by Shailendra Pandey on 11/30/15.
//  Copyright © 2015 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol elasticSearchDelegate <NSObject>
-(void)selectItem:(NSString*)item;
@end

@interface SearchListVC : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchDisplayDelegate>
{
    NSArray *tableData;
    NSArray *searchResults;
    IBOutlet UITableView*datatable;
}
@property (nonatomic, strong) NSMutableArray *searchResult;
@property (nonatomic, strong) NSArray *tableData;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSURLConnection *connection;
@property(nonatomic,retain)IBOutlet UITableView * addressList;
@property (nonatomic, strong)IBOutlet UISearchBar*searchingbar;
@property(nonatomic,strong) id<elasticSearchDelegate> Elasticsearchdelegte;
@end
