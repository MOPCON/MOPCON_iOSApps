//
//  Utility.h
//  MOPCON
//
//  Created by Evan Wu on 13/9/9.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSArray *)sessionParser:(NSDictionary *)dictionary;
+ (NSArray *)newsParser:(NSDictionary *)dictionary;

@end
