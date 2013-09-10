//
//  Session.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/9.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "Session.h"

@implementation Session

- (id)initWithDay:(int)day {
  self = [super init];
  
  if (self) {
    [self setTrackArray:[[NSMutableDictionary alloc] initWithCapacity:3]];
  }
  
  return self;
}

@end
