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
    self.tabBarItem.image = [UIImage imageNamed:@"event_gray.png"];
    isFirstDay = YES;
  }

  return self;
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
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self updateSessionJson];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return (self.sessionDay) ? 4 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (!self.sessionDay) {
    return 0;
  }
  
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
    default:
      break;
  }

  Session *session = [self.sessionDay.sessionDictionary objectForKey:sessionId];
  return session.trackDictionary.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"上午9:00";
    case 1:
      return @"上午10:20";
    case 2:
      return @"下午13:30";
    case 3:
      return @"下午15:10";
    default:
      break;
  }
  return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"SessionViewCell" owner:nil options:nil] lastObject];
  }

  NSString *sessionId;
  switch (indexPath.section) {
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
    default:
      break;
  }
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
//  [cell.textLabel setText:track.name];
//  [cell.detailTextLabel setText:track.speaker];
  
  [(UILabel *)[cell viewWithTag:101] setText:track.name];
  [(UILabel *)[cell viewWithTag:102] setText:track.loc];
  
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
  
  NSString *sessionId;
  switch (indexPath.section) {
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
    default:
      break;
  }
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
  //[view setBackgroundColor:[UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0]];
  //[view setBackgroundColor:[UIColor clearColor]];
  //[view setAlpha:1.0];
  
  ShadowView *sView = [[ShadowView alloc] initWithFrame:CGRectMake(0, 0, 320, 21)];
  [sView setAlpha:0.95];
  [view addSubview:sView];
  [sView viewAppear];
  
  NSString *title;
  switch (section) {
    case 0:
      title = @"上午9:00";
      break;
    case 1:
      title = @"上午10:20";
      break;
    case 2:
      title = @"下午13:30";
      break;
    case 3:
      title = @"下午15:10";
      break;
    default:
      break;
  }
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 17)];
  [label setText:title];
  [label setBackgroundColor:[UIColor clearColor]];
  [view addSubview:label];
  
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SShadow.png"]];
  [imageView setFrame:CGRectMake(0, 0, 320, 0.5)];
  [view addSubview:imageView];
  
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

@end
