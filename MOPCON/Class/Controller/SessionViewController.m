//
//  ViewController.m
//  MOPCON
//
//  Created by Evan Wu on 13/7/16.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "SessionViewController.h"
#import "SessionDetailViewController.h"
#import "URLConnection.h"
#import "CJSONDeserializer.h"
#import "Utility.h"
#import "ShadowView.h"

#import <QuartzCore/QuartzCore.h>

@interface SessionViewController () {
  bool isFirstDay;
}

@end

@implementation SessionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {
    self.title = NSLocalizedString(@"Session", @"Session");
    self.navigationItem.title = @"10月26日星期六";
    self.tabBarItem.image = [UIImage imageNamed:@"event_black.png"];
    isFirstDay = YES;
  }

  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.nextDayButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.nextDayButton setImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
  [self.nextDayButton addTarget:self action:@selector(nextDay:) forControlEvents:UIControlEventTouchUpInside];
  [self.nextDayButton setFrame:CGRectMake(0, 0, 30, 30)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.nextDayButton];
  
  self.preDayButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.preDayButton setImage:[UIImage imageNamed:@"arrow_right.png"] forState:UIControlStateNormal];
  [self.preDayButton addTarget:self action:@selector(preDay:) forControlEvents:UIControlEventTouchUpInside];
  [self.preDayButton setFrame:CGRectMake(0, 0, 30, 30)];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.preDayButton];
  [self.navigationItem.leftBarButtonItem setEnabled:NO];
  
  [self.tableView setRowHeight:54];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSessionJson) name:@"UpdateSession" object:nil];
  [self updateSessionJson];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  //[self updateSessionJson];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return (self.sessionDay) ? 8 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (!self.sessionDay) {
    return 0;
  }
  
  NSString *sessionId = [self getSessionIdInSection:section];

  Session *session = [self.sessionDay.sessionDictionary objectForKey:sessionId];
  return session.trackDictionary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"SessionViewCell" owner:nil options:nil] lastObject];
  }
  
  NSString *sessionId = [self getSessionIdInSection:indexPath.section];
  
  NSString *trackId;
  switch (indexPath.row) {
    case 0:
      trackId = Track0;
      break;
    case 1:
      trackId = Track1;
      break;
    case 2:
      trackId = Track2;
      break;
    default:
      break;
  }
  
  Session *session = [self.sessionDay.sessionDictionary objectForKey:sessionId];
  Track *track = [session.trackDictionary objectForKey:trackId];
  
  [(UILabel *)[cell viewWithTag:101] setText:track.name];
  [(UILabel *)[cell viewWithTag:102] setText:track.loc];
  UIImageView *imageView = (UIImageView *)[cell viewWithTag:103];
  [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", track.catalog]]];
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  SessionDetailViewController *detailViewController;
  if ([[UIScreen mainScreen] bounds].size.height == 568) {
    detailViewController = [[SessionDetailViewController alloc] initWithNibName:@"SessionDetailViewController568" bundle:nil];
  } else {
    detailViewController = [[SessionDetailViewController alloc] initWithNibName:@"SessionDetailViewController" bundle:nil];
  }
  
  NSString *sessionId = [self getSessionIdInSection:indexPath.section];
  
  NSString *trackId;
  switch (indexPath.row) {
    case 0:
      trackId = Track0;
      break;
    case 1:
      trackId = Track1;
      break;
    case 2:
      trackId = Track2;
      break;
    default:
      break;
  }
  
  Session *session = [self.sessionDay.sessionDictionary objectForKey:sessionId];
  Track *track = [session.trackDictionary objectForKey:trackId];
  [detailViewController setTrack:track];
  [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 21.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 21)];
  
  ShadowView *sView = [[ShadowView alloc] initWithFrame:CGRectMake(0, 0, 320, 21)];
  [sView setAlpha:0.95];
  [view addSubview:sView];
  [sView viewAppear];
  
  NSString *title = [self getSessionTimeStringInSection:section];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 200, 17)];
  [label setText:title];
  [label setBackgroundColor:[UIColor clearColor]];
  [view addSubview:label];

  UIView *topline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
  [topline setBackgroundColor:[UIColor lightGrayColor]];
  [view addSubview:topline];
  
  UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, 21, 320, 0.5)];
  [bottomline setBackgroundColor:[UIColor lightGrayColor]];
  [view addSubview:bottomline];
  
  return view;
}

#pragma mark - Action

- (IBAction)preDay:(id)sender {
  self.dayenum = ConfDayOne;
  if (self.sessionArray.count == 2) {
    self.sessionDay = [self.sessionArray objectAtIndex:0];
    self.dayLabel.text = @"10月26日星期六";
    self.navigationItem.title = @"10月26日星期六";
    isFirstDay = YES;
    [self.tableView reloadData];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
  }
}

- (IBAction)nextDay:(id)sender {
  self.dayenum = ConfDayTwo;
  if (self.sessionArray.count == 2) {
    self.sessionDay = [self.sessionArray objectAtIndex:1];
    self.dayLabel.text = @"10月27日星期日";
    self.navigationItem.title = @"10月27日星期日";
    isFirstDay = NO;
    [self.tableView reloadData];
    [self.navigationItem.leftBarButtonItem setEnabled:YES];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
  }
}

#pragma mark - private

- (void)updateSessionJson {
  NSURL               *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mopcon.org/2013/api/session.php"]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  
  [URLConnection asyncConnectionWithRequest:request completionBlock:^(NSData *data, NSURLResponse *response) {
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ResponseBody=%@", jsonString);
    
    NSDictionary *aJsonDict = [[CJSONDeserializer deserializer] deserializeAsDictionary:data error:nil];
    NSString *lastupdate = (NSString *)[aJsonDict objectForKey:@"last_update"];
    NSLog(@"%@", lastupdate);
    
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSData *jsondata = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //[jsondata writeToFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", lastupdate]] atomically:YES];
    [jsondata writeToFile:[documentPath stringByAppendingPathComponent:@"session.txt"] atomically:YES];

    [self setSessionArray:[Utility sessionParser:aJsonDict]];
    
//    NSLog(@"%@, \r\nsession count = %d", self.sessionArray, self.sessionArray.count);
//    
//    for (int i = 0; i < self.sessionArray.count; i++) {
//      SessionDay *d = [self.sessionArray objectAtIndex:i];
//      for (NSString *key in d.sessionDictionary) {
//        Session *s = [d.sessionDictionary objectForKey:key];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"YY-MM-dd HH:mm:ss"];
//        NSLog(@"%@", [dateFormatter stringFromDate:s.time]);
//        for (NSString *k in s.trackDictionary) {
//          Track *tt = [s.trackDictionary objectForKey:k];
//          NSLog(@"%@", tt.trackId);
//          NSLog(@"%@", tt.name);
//          NSLog(@"%@", tt.speaker);
//          NSLog(@"%@", tt.speaker_bio);
//          NSLog(@"%@", tt.loc);
//        }
//      }
//    }
    
    
    if (isFirstDay) {
      self.sessionDay = [self.sessionArray objectAtIndex:0];
      self.dayLabel.text = @"10月26日星期六";
      self.navigationItem.title = @"10月26日星期六";
    } else {
      self.sessionDay = [self.sessionArray objectAtIndex:1];
      self.dayLabel.text = @"10月27日星期日";
      self.navigationItem.title = @"10月27日星期日";
    }
    
    [self.tableView reloadData];
  } errorBlock:^(NSError *error) {
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"session.txt"];
    NSError *errors = nil;
    NSString *file = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&errors];
    NSData *fileData = [file dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *aJsonDict = [[CJSONDeserializer deserializer] deserializeAsDictionary:fileData error:nil];
    [self setSessionArray:[Utility sessionParser:aJsonDict]];
    
    if (isFirstDay) {
      self.sessionDay = [self.sessionArray objectAtIndex:0];
      self.dayLabel.text = @"10月26日星期六";
      self.navigationItem.title = @"10月26日星期六";
    } else {
      self.sessionDay = [self.sessionArray objectAtIndex:1];
      self.dayLabel.text = @"10月27日星期日";
      self.navigationItem.title = @"10月27日星期日";
    }

    [self.tableView reloadData];
  }];
}

- (NSString *)getSessionTimeStringInSection:(NSInteger)section {
  if (isFirstDay) {
    switch (section) {
      case 0:
        return @"上午9:05~9:25";
      case 1:
        return @"上午9:25~10:15";
      case 2:
        return @"上午10:30~11:10";
      case 3:
        return @"上午11:20~12:00";
      case 4:
        return @"下午13:10~14:00";
      case 5:
        return @"下午14:10~14:50";
      case 6:
        return @"下午15:10~15:50";
      case 7:
        return @"下午16:00~16:40";
      default:
        break;
    }
  } else {
    switch (section) {
      case 0:
        return @"上午9:00~9:50";
      case 1:
        return @"上午10:00~10:40";
      case 2:
        return @"上午10:50~11:30";
      case 3:
        return @"上午11:30~12:20";
      case 4:
        return @"下午13:30~14:20";
      case 5:
        return @"下午14:30~15:10";
      case 6:
        return @"下午15:30~16:10";
      case 7:
        return @"下午16:20~17:30";
      default:
        break;
    }
  }
  return @"";
}

- (NSString *)getSessionIdInSection:(NSInteger)section {
  NSString *sessionId;
  switch (section) {
    case 0:
      sessionId = Session0;
      break;
    case 1:
      sessionId = Session1;
      break;
    case 2:
      sessionId = Session2;
      break;
    case 3:
      sessionId = Session3;
      break;
    case 4:
      sessionId = Session4;
      break;
    case 5:
      sessionId = Session5;
      break;
    case 6:
      sessionId = Session6;
      break;
    case 7:
      sessionId = Session7;
      break;
    default:
      sessionId = @"";
      break;
  }
  return sessionId;
}

@end
