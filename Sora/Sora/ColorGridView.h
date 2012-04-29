//
//  ColorGridView.h
//  Sora
//
//  Created by Mike Manzano on 4/28/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import <UIKit/UIKit.h>
//green, blue, purple, red, orange, yellow
typedef enum 
	{
	xkColorGreen = 0,
	xkColorBlue,
	xkColorPurple,
	xkColorRed,
	xkColorOrange,
	xkColorYellow,
	} eColor ;

@interface ColorGridView : UIView
@property (strong, nonatomic ) NSArray *gridColors ; // Major = bar, Minor = instrument
@property (assign, nonatomic ) NSUInteger playheadCount ; // zero-based. That's count as in musical count, not numeric count
@end
