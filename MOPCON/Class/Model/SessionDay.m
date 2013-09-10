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
    
    Session *firstSession = [[Session alloc] init];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:2013];
    [comps setMonth:10];
    if (day == 1) {
      [comps setDay:26];
    } else {
      [comps setDay:27];
    }
    [comps setHour:9];
    [comps setMinute:0];
    firstSession.time = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    Session *secondSession = [[Session alloc] init];
    [comps setYear:2013];
    [comps setMonth:10];
    if (day == 1) {
      [comps setDay:26];
    } else {
      [comps setDay:27];
    }
    [comps setHour:10];
    [comps setMinute:20];
    secondSession.time = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    Session *thirdSession = [[Session alloc] init];
    [comps setYear:2013];
    [comps setMonth:10];
    if (day == 1) {
      [comps setDay:26];
    } else {
      [comps setDay:27];
    }
    [comps setHour:13];
    [comps setMinute:30];
    thirdSession.time = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    Session *fourthSession = [[Session alloc] init];
    [comps setYear:2013];
    [comps setMonth:10];
    if (day == 1) {
      [comps setDay:26];
    } else {
      [comps setDay:27];
    }
    [comps setHour:15];
    [comps setMinute:10];
    fourthSession.time = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    [self setSessionDictionary:@{@"Session1" : firstSession, @"Session2" : secondSession, @"Session3" : thirdSession, @"Session4" : fourthSession}];
  }
  
  return self;
}

@end
