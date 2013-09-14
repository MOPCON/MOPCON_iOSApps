//
//  SessionDetailViewController.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/14.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "SessionDetailViewController.h"

@interface SessionDetailViewController ()

@end

@implementation SessionDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView setRowHeight:420.0f];
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
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"SessionDetailViewCell" owner:nil options:nil] lastObject];
  }
  
  [(UILabel *)[cell viewWithTag:101] setText:self.track.name];
  [(UILabel *)[cell viewWithTag:102] setText:self.track.speaker];
  NSString *content = [NSString stringWithFormat:@"%@\r\n\r\n%@", self.track.content, self.track.speaker_bio];
  [(UILabel *)[cell viewWithTag:103] setText:content];
  
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
