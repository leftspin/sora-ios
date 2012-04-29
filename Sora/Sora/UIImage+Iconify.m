//
//  UIImage+Iconify.m
//  docBeat
//
//  Created by Mike Manzano on 11/3/11.
//  Copyright (c) 2011 docBeat. All rights reserved.
//

#import "UIImage+Iconify.h"
#import "UIImage+Resize.h"

@implementation UIImage (Iconify)

- (UIImage *) iconifyToDimension: (float) xy inset: (float) inset
	{
	return [self thumbnailImage:(NSUInteger)xy transparentBorder:(NSUInteger)inset cornerRadius:6 interpolationQuality:kCGInterpolationLow] ;
	}

@end
