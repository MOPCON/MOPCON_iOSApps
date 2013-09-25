#import "VerticallyAlignedLabel.h"

@implementation VerticallyAlignedLabel

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    verticalAlignment_ = VerticalAlignmentMiddle;
  }
  return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
  verticalAlignment_ = verticalAlignment;
  [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
  CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
  switch (verticalAlignment_) {
    case VerticalAlignmentTop:
      textRect.origin.y = bounds.origin.y;
      break;
    case VerticalAlignmentBottom:
      textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
      break;
    case VerticalAlignmentMiddle:
    default:
      textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
  }
  return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect {
  CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
  [super drawTextInRect:actualRect];
}

@end
