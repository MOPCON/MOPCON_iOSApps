//
//  SessionDetailViewCell.m
//  MOPCON
//
//  Created by Evan Wu on 13/10/4.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "SessionDetailViewCell.h"

@interface SessionDetailViewCell() {
  NSString *_title;
  NSString *_content;
  NSString *_speaker;
  NSString *_spakerBio;
}

@end

@implementation SessionDetailViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

#pragma mark - public

- (void)setSessionTitle:(NSString *)title content:(NSString *)content speaker:(NSString *)speaker speakerBio:(NSString *)bio {
  _title = title;
  _content = content;
  _speaker = speaker;
  _spakerBio = bio;
  [self calculatorTitleField];
}

#pragma mark - private

- (void)calculatorTitleField {
  UILabel *nameLabel = [[UILabel alloc] init];
  int nameLine = (_title.length / 20) + 1;

  [nameLabel setFrame:CGRectMake(20, 20, 280, 21 * nameLine)];
  [nameLabel setNumberOfLines:nameLine + 1];
  [nameLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
  [self addSubview:nameLabel];
  
  [self calculatorContentField];
}

- (void)calculatorContentField {
  [self calculatorSpeakerField];
}

- (void)calculatorSpeakerField {
  [self calculatorBioField];
}

- (void)calculatorBioField {
  
}

@end
