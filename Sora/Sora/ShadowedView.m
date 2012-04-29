//
//  ShadowedView.m
//  Counterless
//
//  Created by Mike Manzano on 1/29/12.
//  Copyright (c) 2012 Counterless. All rights reserved.
//

#import "ShadowedView.h"
#import "ShadowView.h"
#import <QuartzCore/QuartzCore.h>

#define SHADOWED_VIEW_SHADOW_VIEW_TAG 123987
@implementation ShadowedView

#pragma mark - Properties

@synthesize topShadow = topShadow_ ;
- (void) setTopShadow:(BOOL)newTopShadow
	{
	topShadow_ = newTopShadow ;
	[self setNeedsLayout] ;
	}


#pragma mark - Instance

- (void) shadowedViewSetup
	{
	ShadowView *shadowView = [[ShadowView alloc] initWithFrame:CGRectZero] ;
	shadowView.tag = SHADOWED_VIEW_SHADOW_VIEW_TAG ;
	[self addSubview:shadowView] ;
	self.layer.masksToBounds = NO ;
	[self setNeedsLayout] ;
	}
	
- (id)initWithFrame:(CGRect)frame
	{
    self = [super initWithFrame:frame];
    if (self) 
		{
		[self shadowedViewSetup] ;
		}
    return self;
	}
	
- (void) awakeFromNib
	{
	[super awakeFromNib] ;
	[self shadowedViewSetup] ;
	}

- (void) layoutSubviews
	{
	[super layoutSubviews] ;
	ShadowView *shadowView = (ShadowView *)[self viewWithTag:SHADOWED_VIEW_SHADOW_VIEW_TAG] ;
	float y ;
	static float shadowHeight = 5 ;
	if( self.topShadow )
		y = -shadowHeight ;
	else
		y = self.bounds.size.height ;
	shadowView.topShadow = self.topShadow ;
	CGRect shadowViewFrame = CGRectMake(0, y, self.bounds.size.width, shadowHeight) ;
	shadowView.frame = shadowViewFrame ;
	}
@end
