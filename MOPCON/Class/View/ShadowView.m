//
//  ShadowView.m
//  Projector
//
//  Created by wangshuaidavid on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShadowView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShadowView

+ (Class)layerClass {
	return [CAGradientLayer class];
}

- (void)awakeFromNib {
	CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
	[gradientLayer setStartPoint:CGPointMake(0.5, 0.0)];
	[gradientLayer setEndPoint:CGPointMake(0.5, 1.0)];
	
	gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.0 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.3 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.7 alpha:1.0].CGColor, nil];
  
	self.backgroundColor = [UIColor clearColor];
}

- (void)viewAppear {
	CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
	[gradientLayer setStartPoint:CGPointMake(0.5, 0.0)];
	[gradientLayer setEndPoint:CGPointMake(0.5, 1.0)];
	
//	gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.4 alpha:0.5].CGColor, (id)[UIColor colorWithWhite:0.5 alpha:0.5].CGColor, (id)[UIColor colorWithWhite:0.6 alpha:0.5].CGColor, (id)[UIColor colorWithWhite:0.65 alpha:0.5].CGColor, (id)[UIColor colorWithWhite:0.70 alpha:0.5].CGColor, (id)[UIColor colorWithWhite:0.75 alpha:0.5].CGColor, nil];

  gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.65 alpha:0.85].CGColor, (id)[UIColor colorWithWhite:0.7 alpha:0.85].CGColor, (id)[UIColor colorWithWhite:0.8 alpha:0.85].CGColor, (id)[UIColor colorWithWhite:0.85 alpha:0.85].CGColor, (id)[UIColor colorWithWhite:0.90 alpha:0.85].CGColor, (id)[UIColor colorWithWhite:0.95 alpha:0.85].CGColor, nil];
  
// 	gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.70 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.75 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.77 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.78 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.80 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.85 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.9 alpha:1.0].CGColor, (id)[UIColor colorWithWhite:0.96 alpha:0.5].CGColor, (id)[UIColor colorWithWhite:0.98 alpha:0.5].CGColor, nil];
  
	self.backgroundColor = [UIColor clearColor];
}

- (void)setColor {
	CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
	[gradientLayer setStartPoint:CGPointMake(0.5, 0.0)];
	[gradientLayer setEndPoint:CGPointMake(0.5, 1.0)];
	
	CGColorRef color0 = [UIColor colorWithWhite:0.1 alpha:0.6].CGColor;
	CGColorRef color1 = [UIColor colorWithWhite:0.3 alpha:0.3].CGColor;
	CGColorRef color2 = [UIColor colorWithWhite:0.3 alpha:0.0].CGColor;
  
	gradientLayer.colors = [NSArray arrayWithObjects:(__bridge id)color0, (__bridge id)color1, (__bridge id)color2, nil];
	self.backgroundColor = [UIColor clearColor];
}

@end
