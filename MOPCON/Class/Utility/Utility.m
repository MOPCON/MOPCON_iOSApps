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
  
  NSArray *array = (NSArray *)[dictionary objectForKey:@"sessions"];
  
  for (int i = 0; i < array.count; i++) {
    NSDictionary *d = (NSDictionary *)[array objectAtIndex:i];
    NSString *aId = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"id"]];
    NSString *aName = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"name"]];
    NSString *aSpeaker = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"speaker"]];
    NSString *aSpeaker_bio = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"speaker_bio"]];
    NSString *aKeyword = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"keyword"]];
    NSString *aLoc = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"loc"]];
    NSString *aStartTime = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"start_time"]];
    NSString *aEndTime = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"end_time"]];
    
    NSString *sDay = [aId substringWithRange:NSMakeRange(0, 1)];
    int sessionId = [[aId substringWithRange:NSMakeRange(1, 1)] intValue];
    int trackId = [[aId substringWithRange:NSMakeRange(2, 1)] intValue];
    
    Track *track = [[Track alloc] init];
    [track setName:aName];
    [track setSpeaker:aSpeaker];
    [track setSpeaker_bio:aSpeaker_bio];
    [track setKeyword:aKeyword];
    [track setLoc:aLoc];
    [track setStartTime:nil];
    [track setEndTime:nil];
    
    Session *session;
    
    switch ([sDay intValue]) {
      case 1: {
        switch (sessionId) {
          case 0:
            session = [sessionDayOne.sessionDictionary objectForKey:@"Session1"];
            break;
          case 1:
            session = [sessionDayOne.sessionDictionary objectForKey:@"Session2"];
            break;
          case 2:
            session = [sessionDayOne.sessionDictionary objectForKey:@"Session3"];
            break;
          case 3:
            session = [sessionDayOne.sessionDictionary objectForKey:@"Session4"];
            break;
          default:
            break;
        }
      }
        break;
      case 2: {
        switch (sessionId) {
          case 0:
            session = [sessionDayTwo.sessionDictionary objectForKey:@"Session1"];
            break;
          case 1:
            session = [sessionDayTwo.sessionDictionary objectForKey:@"Session2"];
            break;
          case 2:
            session = [sessionDayTwo.sessionDictionary objectForKey:@"Session3"];
            break;
          case 3:
            session = [sessionDayTwo.sessionDictionary objectForKey:@"Session4"];
            break;
          default:
            break;
        }
      }
        break;
      default:
        break;
    }
    [session.trackArray setObject:track forKey:[NSString stringWithFormat:@"Track%d", trackId]];
  }
  
  return @[sessionDayOne, sessionDayTwo];
}

@end
