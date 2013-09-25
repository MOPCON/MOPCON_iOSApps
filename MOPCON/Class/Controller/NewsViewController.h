//
//  NewsViewController.h
//  MOPCON
//
//  Created by Evan Wu on 13/7/16.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) NSArray               *newsArray;

@end
