//
//  ViewController.m
//  MOPCON
//
//  Created by Evan Wu on 13/7/16.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "ViewController.h"
#import "URLConnection.h"
#import "CJSONDeserializer.h"
#import "Utility.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {
    self.title = NSLocalizedString(@"Session", @"Session");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

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
    [jsondata writeToFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", lastupdate]] atomically:YES];
    
    
    [self setSessionArray:[Utility sessionParser:aJsonDict]];
    NSLog(@"%@, \r\nsession count = %d", self.sessionArray, self.sessionArray.count);
    
    for (int i = 0; i < self.sessionArray.count; i++) {
      SessionDay *d = [self.sessionArray objectAtIndex:i];
      for (NSString *key in d.sessionDictionary) {
        Session *s = [d.sessionDictionary objectForKey:key];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YY-MM-dd HH:mm:ss"];
        NSLog(@"%@", [dateFormatter stringFromDate:s.time]);
        for (NSString *k in s.trackDictionary) {
          Track *tt = [s.trackDictionary objectForKey:k];
          NSLog(@"%@", tt.name);
          NSLog(@"%@", tt.speaker);
          NSLog(@"%@", tt.speaker_bio);
          NSLog(@"%@", tt.loc);
        }
      }
    }
    
    
    self.sessionDay = [self.sessionArray objectAtIndex:0];
    [self.tableView reloadData];
    
  } errorBlock:^(NSError *error) {}];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  [cell.textLabel setText:[NSString stringWithFormat:@"%d", indexPath.row]];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Navigation logic may go here. Create and push another view controller.
  /*
   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
   // ...
   // Pass the selected object to the new view controller.
   [self.navigationController pushViewController:detailViewController animated:YES];
   */
}

#pragma mark - Action

- (IBAction)preDay:(id)sender {
  self.dayenum = ConfDayOne;
  if (self.sessionArray.count == 2) {
    self.sessionDay = [self.sessionArray objectAtIndex:0];
  }
}

- (IBAction)nextDay:(id)sender {
  self.dayenum = ConfDayTwo;
  if (self.sessionArray.count == 2) {
    self.sessionDay = [self.sessionArray objectAtIndex:1];
  }
}

@end
