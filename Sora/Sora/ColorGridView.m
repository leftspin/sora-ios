//
//  ColorGridView.m
//  Sora
//
//  Created by Mike Manzano on 4/28/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import "ColorGridView.h"

@implementation ColorGridView
	{
	}

#pragma mark - Properties

@synthesize playheadCount = playheadCount_ ;
- (void) setPlayheadCount:(NSUInteger)playheadCount
	{
	playheadCount_ = playheadCount ;
	[self setNeedsDisplay] ;
	}

@synthesize gridColors = gridColors_ ;
- (void) setGridColors:(NSArray *)gridColors
	{
	gridColors_ = gridColors ;
	[self setNeedsDisplay] ;
	}

#pragma mark - Instance

- (id)initWithFrame:(CGRect)frame
	{
    self = [super initWithFrame:frame];
    if (self) 
		{
		}
    return self;
	}

- (void) awakeFromNib
	{
        // Initialize with test pattern
		self.gridColors = [NSArray arrayWithObjects:
		
			// Count 1
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 2
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 3
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				nil] ,

			// Count 4
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 1
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				nil] ,

			// Count 2
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 3
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 4
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 1
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				nil] ,

			// Count 2
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				nil] ,

			// Count 3
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				nil] ,

			// Count 4
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 1
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 2
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 3
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				nil] ,

			// Count 4
			[NSArray arrayWithObjects:
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:1],
				[NSNumber numberWithBool:0],
				[NSNumber numberWithBool:0],
				nil] ,

			nil] ;
	}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
	{
	CGFloat boxWidth = self.bounds.size.width / self.gridColors.count ;
	CGFloat boxHeight = self.bounds.size.height / ((NSArray *)[self.gridColors objectAtIndex:0]).count ;
	
	[self.gridColors enumerateObjectsUsingBlock:^(id obj, NSUInteger barIndex, BOOL *stop)
		{
		NSArray *instruments = (NSArray *) obj ;
		[instruments enumerateObjectsUsingBlock:^(id obj, NSUInteger instrumentIndex, BOOL *stop)
			{
			NSNumber *notePlayingNumber = (NSNumber *)obj ;
			BOOL notePlaying = notePlayingNumber.boolValue ;
			NSLog(@"%@", notePlaying ? @"YES":@"NO") ;
			
			CGFloat alpha = 0 ;
			UIColor *drawColor = [UIColor blackColor] ;

			if( barIndex >= self.playheadCount || barIndex <= self.playheadCount - 7)
				{
				if( notePlaying )
					alpha = 1 ;
				else
					alpha = 0 ;
				drawColor = [UIColor colorWithWhite:0 alpha:alpha] ;
				}
			else
				{
				if( notePlaying )
					{
					if( barIndex == self.playheadCount - 1 )
						alpha = 1 ;
					if( barIndex == self.playheadCount - 2 )
						alpha = 0.5 ;
					if( barIndex == self.playheadCount - 3 )
						alpha = 0.4 ;
					if( barIndex == self.playheadCount - 4 )
						alpha = 0.3 ;
					if( barIndex == self.playheadCount - 5 )
						alpha = 0.2 ;
					if( barIndex == self.playheadCount - 6 )
						alpha = 0.1 ;
					}
				else
					alpha = 0 ;
				
				switch( instrumentIndex )
					{
					case xkColorGreen:
						drawColor = RGBACOLOR(0, 255, 0, alpha) ;
						break ;
					
					case xkColorBlue:
						drawColor = RGBACOLOR(0, 0, 255, alpha) ;
						break ;
						
					case xkColorPurple:
						drawColor = RGBACOLOR(255, 0, 255, alpha) ;
						break ;
						
					case xkColorRed:
						drawColor = RGBACOLOR(255, 0, 0, alpha) ;
						break ;
						
					case xkColorOrange:
						drawColor = RGBACOLOR(255, 120, 0, alpha) ;
						break ;
						
					case xkColorYellow:
						drawColor = RGBACOLOR(255, 255, 0, alpha) ;
						break ;
						
					default:
						drawColor = [UIColor colorWithWhite:1 alpha:0.5] ;
					} ; // switch color
				} // barIndex vs. playhead
				
			[drawColor set] ;
			
			CGFloat x = barIndex * boxWidth ;
			CGFloat y = instrumentIndex * boxHeight ;
			
			UIRectFill(CGRectMake(x, y, boxWidth, boxHeight)) ;
			}] ;
		}] ;
		
	// Draw the play head (playhead is 15 x 10)
	CGFloat playheadX = boxWidth * self.playheadCount ;
	UIBezierPath *bezierPath = [UIBezierPath bezierPath] ;
	[bezierPath moveToPoint:CGPointMake(playheadX, 0)] ;
	[bezierPath addLineToPoint:CGPointMake(playheadX, self.bounds.size.height)] ;
	[bezierPath setLineWidth:3] ;
	[[UIColor whiteColor] set] ;
	[bezierPath stroke] ;
	
//	CGContextRef gc = UIGraphicsGetCurrentContext() ;
//	
//	// Gradient
//	/*
//	 float locations[2] = {0.9,0};
//	 float components[8] =	{  
//	 0,0,0,0.3,
//	 1,1,1,0.22, 
//	 };
//	 */
//	float locations[2] = {0,1} ;
//	float components[8] =	{  
//		0,0,0,1,
//		0,0,0,0,
//	};
//	
//	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//	CGGradientRef gradient = CGGradientCreateWithColorComponents( colorSpace, components, locations,  2);
//	
//	CGPoint startPoint, endPoint;
//	
//	startPoint = CGPointMake(playheadX, 0);
//	endPoint = CGPointMake(playheadX+400, 0) ;
//	CGContextDrawLinearGradient( gc, gradient, startPoint, endPoint, 0 );
//	
//	CFRelease(gradient) ;
//	CFRelease(colorSpace) ;
	}

@end
