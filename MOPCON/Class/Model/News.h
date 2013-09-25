//
//  News.h
//  MOPCON
//
//  Created by Evan Wu on 13/9/25.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, strong) NSString *newsId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *time;

@end
