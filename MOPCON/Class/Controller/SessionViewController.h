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

@interface SessionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) IBOutlet UILabel      *dayLabel;
@property (nonatomic, strong) IBOutlet UIButton     *preDayButton;
@property (nonatomic, strong) IBOutlet UIButton     *nextDayButton;
@property (nonatomic, strong) NSArray               *sessionArray;
@property (nonatomic, strong) SessionDay            *sessionDay;
@property (nonatomic, assign) ConfDayEnum           dayenum;
//@property (nonatomic, strong) UI

- (IBAction)preDay:(id)sender;
- (IBAction)nextDay:(id)sender;

@end
