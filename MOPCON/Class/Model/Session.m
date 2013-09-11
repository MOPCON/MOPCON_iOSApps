//
//  Session.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/9.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "Session.h"

@implementation Session

- (id)init {
  self = [super init];
  
  if (self) {
    [self setTrackDictionary:[[NSMutableDictionary alloc] initWithCapacity:3]];
  }
  
  return self;
}

@end
