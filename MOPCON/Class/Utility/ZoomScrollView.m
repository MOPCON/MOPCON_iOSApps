//
//  ZoomScrollView.m
//  MOPCON
//
//  Created by Evan Wu on 13/9/23.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

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

  // The imageView can be zoomed largest size

  if ([[UIScreen mainScreen] bounds].size.height == 568) {
    self.imageView.frame = CGRectMake(0, 0, ScreenWidth * 3.5, (ScreenHeight - 22) * 1.7);
  } else {
    self.imageView.frame = CGRectMake(0, 0, ScreenWidth * 3.5, (ScreenHeight - 22) * 2.0);
  }
  
  
  self.imageView.userInteractionEnabled = YES;
  [self addSubview:self.imageView];

  // Add gesture,double tap zoom imageView.
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

#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
  float   newScale = self.zoomScale * 1.5;
  CGRect  zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];

  [self zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
  CGRect zoomRect;

  zoomRect.size.height = self.frame.size.height / scale;
  zoomRect.size.width = self.frame.size.width / scale;
  zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
  zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
  return zoomRect;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
  [scrollView setZoomScale:scale animated:NO];
}

@end
