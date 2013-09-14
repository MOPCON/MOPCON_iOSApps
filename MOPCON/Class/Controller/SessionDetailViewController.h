//
//  SessionDetailViewController.h
//  MOPCON
//
//  Created by Evan Wu on 13/9/14.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Track.h"

@interface SessionDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) Track                 *track;

@end
