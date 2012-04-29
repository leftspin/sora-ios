//
//  PlaybackController.h
//  Sora
//
//  Created by Mike Manzano on 4/28/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PlaybackFinishedBlock)(void) ;

@interface PlaybackController : UIViewController
@property( strong, nonatomic ) NSDictionary *patternDescriptor ;
@property( strong, nonatomic ) UIImage *image ;
@property( copy, nonatomic ) PlaybackFinishedBlock playbackFinishedBlock ;
@end
