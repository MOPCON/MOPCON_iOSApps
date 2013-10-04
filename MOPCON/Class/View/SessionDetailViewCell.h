//
//  SessionDetailViewCell.h
//  MOPCON
//
//  Created by Evan Wu on 13/10/4.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionDetailViewCell : UITableViewCell

@property (nonatomic, assign) float viewHeight;

- (void)setSessionTitle:(NSString *)title content:(NSString *)content speaker:(NSString *)speaker speakerBio:(NSString *)bio;

@end
