//
//  SessionDay.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/9.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "SessionDay.h"

@implementation SessionDay

- (id)initWithDay:(int)day {
  self = [super init];
  
  if (self) {
    [self setDay:[NSNumber numberWithInt:day]];
    [self setSessionArray:[[NSMutableArray alloc] initWithCapacity:4]];
  }
  
  return self;
}

@end
