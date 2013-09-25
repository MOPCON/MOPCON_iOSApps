//
//  MapViewController.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/8.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {
    self.title = NSLocalizedString(@"Map", @"Map");
    self.tabBarItem.image = [UIImage imageNamed:@"maps_gray.png"];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.scrollView = [[ZoomScrollView alloc] initWithFrame:self.view.frame];
  [self.scrollView.imageView setImage:[UIImage imageNamed:@"map.png"]];
  [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
