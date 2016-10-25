//
//  CategoryListVC.h
//  CHIBLEE
//
//  Created by Macbook Pro on 30/09/16.
//  Copyright © 2016 Shailendra Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol categoryDelegate <NSObject>
-(void)selectcategory:(NSString*)category;
@end

@interface CategoryVC : UIViewController
@property (nonatomic, strong) id <categoryDelegate>categoydelegate;

@end
