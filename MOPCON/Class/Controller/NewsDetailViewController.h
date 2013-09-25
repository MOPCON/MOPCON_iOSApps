//
//  NewsDetailViewController.h
//  MOPCON
//
//  Created by Evan Wu on 13/9/25.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) News                  *news;

@end
