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
  NSArray *array = (NSArray *)[dictionary objectForKey:@"sessions"];
  
  for (int i = 0; i < array.count; i++) {
    NSDictionary *d = (NSDictionary *)[array objectAtIndex:i];
    NSString *aId = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"id"]];
    NSString *sDay = [aId substringWithRange:NSMakeRange(0, 1)];
    
    SessionDay *sessionDay = [[SessionDay alloc] init];
    sessionDay.day = [NSNumber numberWithInt:[sDay intValue]];
    
    NSLog(@"==%@", sessionDay.day.stringValue);
  }
  
  return nil;
}

@end
