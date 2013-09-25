#import "ZoomScrollView.h"

#define ScreenWidth   CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define ScreenHeight  CGRectGetHeight([UIScreen mainScreen].applicationFrame)

@interface ZoomScrollView () {}

@end

@implementation ZoomScrollView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    self.delegate = self;
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);

    [self initImageView];
  }

  return self;
}

- (void)initImageView {
  self.imageView = [[UIImageView alloc] init];

  if ([[UIScreen mainScreen] bounds].size.height == 568) {
    self.imageView.frame = CGRectMake(0, 0, ScreenWidth * 3.5, (ScreenHeight - 22) * 1.7);
  } else {
    self.imageView.frame = CGRectMake(0, 0, ScreenWidth * 3.5, (ScreenHeight - 22) * 2.0);
  }
  self.imageView.userInteractionEnabled = YES;
  [self addSubview:self.imageView];

  UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
  [doubleTapGesture setNumberOfTapsRequired:2];
  [self.imageView addGestureRecognizer:doubleTapGesture];

  float minimumScale = self.frame.size.width / self.imageView.frame.size.width;
  [self setMinimumZoomScale:minimumScale];
  [self setZoomScale:minimumScale];
  
  if ([[UIScreen mainScreen] bounds].size.height == 568) {
    [self setZoomScale:1.7];
    [self scrollRectToVisible:CGRectMake(388, 200, 320, 568) animated:NO];
  } else {
    [self setZoomScale:2.0];
    [self scrollRectToVisible:CGRectMake(388, 200, 320, 640) animated:NO];
  }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
  [scrollView setZoomScale:scale animated:NO];
}

#pragma mark - private

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
  float   scale = self.zoomScale * 1.5;
  
  CGPoint center = [gesture locationInView:gesture.view];
  CGRect rect;
  
  rect.size.height = self.frame.size.height / scale;
  rect.size.width = self.frame.size.width / scale;
  rect.origin.x = center.x - (rect.size.width / 2.0);
  rect.origin.y = center.y - (rect.size.height / 2.0);
  
  [self zoomToRect:rect animated:YES];
}

@end
