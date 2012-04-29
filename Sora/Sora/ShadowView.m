//
//  ShadowView.m
//  Counterless
//
//  Created by Mike Manzano on 1/28/12.
//  Copyright (c) 2012 Counterless. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView

#pragma mark - Properties

@synthesize topShadow = topShadow_ ;
- (void) setTopShadow:(BOOL)newTopShadow
	{
	topShadow_ = newTopShadow ;
	if( newTopShadow )
		{
		self.startLocation = 1 ;
		self.endLocation = 0.1 ;
		}
	else
		{
		self.startLocation = 0 ;
		self.endLocation = 0.9 ;
		}
		
	[self setNeedsDisplay] ;
	}

#pragma mark - Instance

- (void) shadowViewSetup
	{
	self.backgroundColor = [UIColor clearColor] ;
	
	RGBColorComponents color1Component ;
	color1Component.r = color1Component.g = color1Component.b = 0 ;
	color1Component.a = 0.32 ;
	self.startColor = color1Component ;
	
	RGBColorComponents color2Component ;
	color2Component.r = color2Component.g = color2Component.b = 0 ;
	color2Component.a = 0.01 ;
	self.endColor = color2Component ;
	
	self.topShadow = NO ;
	
	[self setNeedsDisplay] ;
	}
	
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
		{
		[self shadowViewSetup] ;
		}
    return self;
}

- (void) awakeFromNib
	{
	[self shadowViewSetup] ;
	}
@end
