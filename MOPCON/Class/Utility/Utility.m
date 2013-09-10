//
//  Utility.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/9.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "Utility.h"
#import "SessionDay.h"
#import "Session.h"
#import "Track.h"

@implementation Utility

+ (NSArray *)sessionParser:(NSDictionary *)dictionary {
  SessionDay *sessionDayOne = [[SessionDay alloc] initWithDay:1];
  SessionDay *sessionDayTwo = [[SessionDay alloc] initWithDay:2];
  NSArray *sessionResultArray = @[sessionDayOne, sessionDayTwo, nil];
  
  NSArray *array = (NSArray *)[dictionary objectForKey:@"sessions"];
  
  for (int i = 0; i < array.count; i++) {
    NSDictionary *d = (NSDictionary *)[array objectAtIndex:i];
    NSString *aId = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"id"]];
    NSString *sDay = [aId substringWithRange:NSMakeRange(0, 1)];
    
    SessionDay *sessionDay = [[SessionDay alloc] init];
    sessionDay.day = [NSNumber numberWithInt:[sDay intValue]];
    
    int sessionId = [[aId substringWithRange:NSMakeRange(1, 1)] intValue];
    
    switch (sessionId) {
      case 0:
        ;
        break;
      case 1:
        ;
        break;
      case 2:
        ;
        break;
      case 3:
        ;
        break;
      default:
        break;
    }
    
    NSLog(@"==%@", sessionDay.day.stringValue);
  }
  
  return nil;
}

@end
