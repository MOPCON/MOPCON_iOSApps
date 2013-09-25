//
//  NewsViewController.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/8.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "NewsViewController.h"
#import "CJSONDeserializer.h"
#import "URLConnection.h"
#import "Utility.h"
#import "News.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {
    self.title = NSLocalizedString(@"News", @"News");
    self.tabBarItem.image = [UIImage imageNamed:@"news_gray.png"];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self updateNewsJson];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return (self.newsArray && self.newsArray.count > 0) ? self.newsArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  News *news = [self.newsArray objectAtIndex:indexPath.row];
  //[(UILabel *)[cell viewWithTag:101] setText:news.title];
  [cell.textLabel setText:news.title];
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
//  SessionDetailViewController *detailViewController;
//  if ([[UIScreen mainScreen] bounds].size.height == 568) {
//    detailViewController = [[SessionDetailViewController alloc] initWithNibName:@"SessionDetailViewController568" bundle:nil];
//  } else {
//    detailViewController = [[SessionDetailViewController alloc] initWithNibName:@"SessionDetailViewController" bundle:nil];
//  }
  
}

#pragma mark - private

- (void)updateNewsJson {
  NSURL               *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mopcon.org/2013/api/news.php"]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  
  [URLConnection asyncConnectionWithRequest:request completionBlock:^(NSData *data, NSURLResponse *response) {
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ResponseBody=%@", jsonString);
    
    NSDictionary *aJsonDict = [[CJSONDeserializer deserializer] deserializeAsDictionary:data error:nil];
    
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSData *jsondata = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [jsondata writeToFile:[documentPath stringByAppendingPathComponent:@"news.txt"] atomically:YES];
    
    [self setNewsArray:[Utility newsParser:aJsonDict]];
    [self.tableView reloadData];
  } errorBlock:^(NSError *error) {
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"news.txt"];
    NSError *errors = nil;
    NSString *file = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&errors];
    NSData *fileData = [file dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *aJsonDict = [[CJSONDeserializer deserializer] deserializeAsDictionary:fileData error:nil];
    [self setNewsArray:[Utility newsParser:aJsonDict]];
    [self.tableView reloadData];
  }];
}

@end
