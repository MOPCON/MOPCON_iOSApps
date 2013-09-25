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
#import "News.h"

@implementation Utility

+ (NSArray *)sessionParser:(NSDictionary *)dictionary {
  SessionDay *sessionDayOne = [[SessionDay alloc] initWithDay:1];
  SessionDay *sessionDayTwo = [[SessionDay alloc] initWithDay:2];
  
  NSArray *array = (NSArray *)[dictionary objectForKey:@"sessions"];
  
  for (int i = 0; i < array.count; i++) {
    NSDictionary *d = (NSDictionary *)[array objectAtIndex:i];
    NSString *aId = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"id"]];
    NSString *aName = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"name"]];
    NSString *aContent = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"content"]];
    NSString *aSpeaker = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"speaker"]];
    NSString *aSpeaker_bio = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"speaker_bio"]];
    NSString *aKeyword = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"keyword"]];
    NSString *aLoc = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"loc"]];
    NSString *aCatalog = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"catalog"]];
    NSString *aStartTime = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"start_time"]];
    NSString *aEndTime = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"end_time"]];
    
    NSString *sDay = [aId substringWithRange:NSMakeRange(0, 1)];
    int sessionId = [[aId substringWithRange:NSMakeRange(1, 1)] intValue];
    int trackId = [[aId substringWithRange:NSMakeRange(2, 1)] intValue];
    
    Track *track = [[Track alloc] init];
    [track setTrackId:aId];
    [track setName:aName];
    [track setContent:aContent];
    [track setSpeaker:aSpeaker];
    [track setSpeaker_bio:aSpeaker_bio];
    [track setKeyword:aKeyword];
    [track setLoc:aLoc];
    [track setCatalog:aCatalog];
    [track setStartTime:nil];
    [track setEndTime:nil];
    
    Session *session;
    
    switch ([sDay intValue]) {
      case 1: {
        switch (sessionId) {
          case 0:
            session = [sessionDayOne.sessionDictionary objectForKey:Session0];
            break;
          case 1:
            session = [sessionDayOne.sessionDictionary objectForKey:Session1];
            break;
          case 2:
            session = [sessionDayOne.sessionDictionary objectForKey:Session2];
            break;
          case 3:
            session = [sessionDayOne.sessionDictionary objectForKey:Session3];
            break;
          default:
            break;
        }
      }
        break;
      case 2: {
        switch (sessionId) {
          case 0:
            session = [sessionDayTwo.sessionDictionary objectForKey:Session0];
            break;
          case 1:
            session = [sessionDayTwo.sessionDictionary objectForKey:Session1];
            break;
          case 2:
            session = [sessionDayTwo.sessionDictionary objectForKey:Session2];
            break;
          case 3:
            session = [sessionDayTwo.sessionDictionary objectForKey:Session3];
            break;
          default:
            break;
        }
      }
        break;
      default:
        break;
    }
    //[session.trackDictionary setObject:track forKey:[NSString stringWithFormat:@"Track%d", trackId]];
    //[session.trackDictionary setValue:track forKey:[NSString stringWithFormat:@"Track%d", trackId]];
    NSString *trackS = [NSString stringWithFormat:@"Track%d", trackId];
    [session.trackDictionary setValue:track forKey:trackS];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YY-MM-dd HH:mm:ss"];
    NSLog(@"%@", [dateFormatter stringFromDate:session.time]);
    NSDictionary *dict = session.trackDictionary;
    NSLog(@"%@", dict);
    
    //Session *a = [sessionDayOne.sessionDictionary objectForKey:Session0];
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"YY-MM-dd HH:mm:ss"];
    //NSLog(@"%@", [dateFormatter stringFromDate:a.time]);
    
    for (NSString *key in sessionDayOne.sessionDictionary) {
      Session *ss = [sessionDayOne.sessionDictionary objectForKey:key];
      
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"YY-MM-dd HH:mm:ss"];
      NSLog(@"%@", [dateFormatter stringFromDate:ss.time]);
      
      NSLog(@"%d", ss.trackDictionary.count);
      for (NSString *k in ss.trackDictionary) {
        Track *tt = [ss.trackDictionary objectForKey:k];
        NSLog(@"%@", tt.trackId);
        NSLog(@"%@", tt.name);
        NSLog(@"%@", tt.content);
        NSLog(@"%@", tt.speaker);
        NSLog(@"%@", tt.speaker_bio);
        NSLog(@"%@", tt.loc);
        NSLog(@"%@", tt.catalog);
      }
    }
  }
  
  return @[sessionDayOne, sessionDayTwo];
}

+ (NSArray *)newsParser:(NSDictionary *)dictionary {
  NSMutableArray *newsArray = [[NSMutableArray alloc] initWithCapacity:10];
  NSArray *array = (NSArray *)[dictionary objectForKey:@"news"];
  
  for (int i = 0; i < array.count; i++) {
    NSDictionary *d = (NSDictionary *)[array objectAtIndex:i];
    NSString *aId = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"id"]];
    NSString *aTitle = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"title"]];
    NSString *aContent = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"content"]];
    //NSString *aPubtime = [NSString stringWithFormat:@"%@", (NSString *)[d objectForKey:@"pub_time"]];
    
    News *news = [[News alloc] init];
    [news setNewsId:aId];
    [news setTitle:aTitle];
    [news setContent:aContent];
    [newsArray addObject:news];
  }
  
  for (int i = 0; i < newsArray.count; i++) {
    News *news = [newsArray objectAtIndex:i];
    NSLog(@"%@", news.newsId);
    NSLog(@"%@", news.title);
    NSLog(@"%@", news.content);
  }
  
  return newsArray;
}

@end
