//
//  GradientView.m
//  IVM
//
//  Created by Mike Manzano on 12/26/11.
//  Copyright (c) 2011 Instant Voodoo Magic. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

#pragma mark - Properties

@synthesize startColor=_startColor, endColor=_endColor, topLineColor=_topLineColor, bottomLineColor=_bottomLineColor, startLocation, endLocation ;

- (void) setStartColor:(RGBColorComponents)startColor
	{
	_startColor = startColor ;
	[self setNeedsDisplay] ;
	}
	
- (void) setEndColor:(RGBColorComponents)endColor
	{
	_endColor = endColor ;
	[self setNeedsDisplay] ;
	}
	
- (void) setTopLineColor:(UIColor *)topLineColor
	{
	_topLineColor = topLineColor ;
	[self setNeedsDisplay] ;
	}
	
- (void) setBottomLineColor:(UIColor *)bottomLineColor
	{
	_bottomLineColor = bottomLineColor ;
	[self setNeedsDisplay] ;
	}

#pragma mark - Instance

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - UIView

- (void)drawRect:(CGRect)rect
	{
	// The background has the noise pattern so we just draw a translucent gradient on top of it
	CGContextRef gc = UIGraphicsGetCurrentContext() ;
	
	// Gradient
	/*
	 float locations[2] = {0.9,0};
	 float components[8] =	{  
	 0,0,0,0.3,
	 1,1,1,0.22, 
	 };
	 */
	float locations[2] = {self.startLocation,self.endLocation};
	float components[8] =	{  
		self.startColor.r, self.startColor.g, self.startColor.b, self.startColor.a ,
		self.endColor.r, self.endColor.g, self.endColor.b, self.endColor.a
	};
	 
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents( colorSpace, components, locations,  2);
	
	CGPoint startPoint, endPoint;
	
	startPoint = CGPointMake(0, 0);
	endPoint = CGPointMake(0, self.bounds.size.height);
	CGContextDrawLinearGradient( gc, gradient, startPoint, endPoint, 0 );
	
	CFRelease(gradient) ;
	CFRelease(colorSpace) ;
	
	// Top line
	if( self.topLineColor )
		{
		[self.topLineColor set] ;
		CGContextBeginPath(gc) ;
		CGContextMoveToPoint(gc, 0, 0.5) ;
		CGContextAddLineToPoint(gc, self.bounds.size.width, 0.5) ;
		CGContextStrokePath(gc) ;
		}
		
	// Bottom line
	if( self.bottomLineColor )
		{
		[self.bottomLineColor set] ;
		CGContextBeginPath(gc) ;
		CGContextMoveToPoint(gc, 0, self.bounds.size.height - 0.5) ;
		CGContextAddLineToPoint(gc, self.bounds.size.width, self.bounds.size.height - 0.5) ;
		CGContextStrokePath(gc) ;
		}
	}

@end
