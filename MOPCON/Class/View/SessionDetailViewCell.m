//
//  SessionDetailViewCell.m
//  MOPCON
//
//  Created by Evan Wu on 13/10/4.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "SessionDetailViewCell.h"
#import "VerticallyAlignedLabel.h"

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
  UILabel *label = [[UILabel alloc] init];
  [label setText:_title];
  int lineNumber = (_title.length / 22) + 1;

  [label setFrame:CGRectMake(20, 0, 280, 22 * lineNumber)];
  [label setNumberOfLines:lineNumber + 1];
  [label setFont:[UIFont boldSystemFontOfSize:17.0f]];
  [self addSubview:label];
  [label setBackgroundColor:[UIColor redColor]];
  [self calculatorContentField:label.frame.origin.y + label.frame.size.height + 10];
}

- (void)calculatorContentField:(float)originY {
  VerticallyAlignedLabel *label = [[VerticallyAlignedLabel alloc] init];
  label.verticalAlignment = VerticalAlignmentMiddle;
  [label setText:_content];
  int lineNumber = (_content.length / 20) + 1;
  
  NSArray *breakings = [_content componentsSeparatedByString:@"\n"];
  lineNumber += breakings.count;
  
  [label setFrame:CGRectMake(20, originY, 280, 20 * lineNumber)];
  [label setNumberOfLines:lineNumber + 1];
  [label setFont:[UIFont systemFontOfSize:16.0f]];
  [self addSubview:label];

  [self calculatorSpeakerField:label.frame.origin.y + label.frame.size.height];
}

- (void)calculatorSpeakerField:(float)originY {
  UILabel *label = [[UILabel alloc] init];
  [label setText:_speaker];
  int lineNumber = (_speaker.length / 20) + 1;
  
  [label setFrame:CGRectMake(20, originY, 280, 40 * lineNumber)];
  [label setNumberOfLines:lineNumber + 1];
  [label setFont:[UIFont boldSystemFontOfSize:17.0f]];
  [label setTextColor:[UIColor blueColor]];

  [self addSubview:label];
  
  [self calculatorBioField:label.frame.origin.y + label.frame.size.height];
}

- (void)calculatorBioField:(float)originY {
  VerticallyAlignedLabel *label = [[VerticallyAlignedLabel alloc] init];
  label.verticalAlignment = VerticalAlignmentTop;
  [label setText:_spakerBio];
  int lineNumber = (_spakerBio.length / 18) + 1;

  NSArray *breakings = [_content componentsSeparatedByString:@"\n"];
  lineNumber += breakings.count;
  
  [label setFrame:CGRectMake(20, originY, 280, 21 * lineNumber)];
  [label setNumberOfLines:lineNumber + 1];
  [label setFont:[UIFont systemFontOfSize:16.0f]];
  [label setTextColor:[UIColor colorWithWhite:0.4 alpha:1.0]];

  self.viewHeight = label.frame.origin.y + label.frame.size.height + 5;
  
  [self addSubview:label];
}

@end
