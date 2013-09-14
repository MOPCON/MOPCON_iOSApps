//
//  Track.h
//  MOPCON
//
//  Created by Evan Wu on 13/9/9.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *speaker;
@property (nonatomic, strong) NSString *speaker_bio;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *loc;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

@end
