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
    
    [self setSessionArray:(NSArray *)[aJsonDict objectForKey:@"sessions"]];
    NSLog(@"%@, \r\nsession count = %d", self.sessionArray, self.sessionArray.count);
    
    for (int i = 0; i < self.sessionArray.count; i++) {
      NSDictionary *d = (NSDictionary *)[self.sessionArray objectAtIndex:i];
      NSString *s = (NSString *)[d objectForKey:@"id"];
      NSLog(@"%@", s);
    }
  } errorBlock:^(NSError *error) {}];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
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
@end
