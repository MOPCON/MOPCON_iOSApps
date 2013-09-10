//
//  ViewController.h
//  MOPCON
//
//  Created by Evan Wu on 13/7/16.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionDay.h"
#import "Session.h"
#import "Track.h"

enum {
  ConfDayOne = 0,
  ConfDayTwo,
};
typedef int ConfDayEnum;

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *sessionArray;
@property (nonatomic, strong) SessionDay *sessionDay;
@property (nonatomic, assign) ConfDayEnum dayenum;

- (IBAction)preDay:(id)sender;
- (IBAction)nextDay:(id)sender;

@end
