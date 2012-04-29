//
//  GradientView.h
//  IVM
//
//  Created by Mike Manzano on 12/26/11.
//  Copyright (c) 2011 Instant Voodoo Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct RGBColorComponents
	{
	float r ;
	float g ;
	float b ;
	float a ;
	} RGBColorComponents ;
	
@interface GradientView : UIView
@property( assign, nonatomic ) RGBColorComponents startColor ;
@property( assign, nonatomic ) RGBColorComponents endColor ;
@property( assign, nonatomic ) float startLocation ; // 0…1
@property( assign, nonatomic ) float endLocation ;
@property( retain, nonatomic ) UIColor *topLineColor ;
@property( retain, nonatomic ) UIColor *bottomLineColor ;
@end
