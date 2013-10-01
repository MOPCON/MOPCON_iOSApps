//
//  SessionDay.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/9.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "SessionDay.h"
#import "Session.h"

@implementation SessionDay

- (id)initWithDay:(int)day {
  self = [super init];
  
  if (self) {
    [self setDay:[NSNumber numberWithInt:day]];

    [self setSessionDictionary:@{Session0 : [[Session alloc] init], Session1 : [[Session alloc] init], Session2 : [[Session alloc] init], Session3 : [[Session alloc] init], Session4 : [[Session alloc] init], Session5 : [[Session alloc] init], Session6 : [[Session alloc] init], Session7 : [[Session alloc] init]}];
  }
  
  return self;
}

@end
