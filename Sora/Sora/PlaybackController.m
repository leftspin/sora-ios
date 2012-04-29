//
//  PlaybackController.m
//  Sora
//
//  Created by Mike Manzano on 4/28/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import "PlaybackController.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorGridView.h"

@interface PlaybackController ()

@end

@implementation PlaybackController
	{
	IBOutlet UIImageView *headerImageView_;
	IBOutlet UIImageView *imageView_;
	IBOutlet ColorGridView *colorGridView_;
	}

#pragma mark - Properties

@synthesize patternDescriptor, image, playbackFinishedBlock ;

#pragma mark - Instance

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
	{
    [super viewDidLoad];
	
	headerImageView_.image = [UIImage imageNamed:@"header"] ;
	
	imageView_.contentMode = UIViewContentModeScaleAspectFill ;
	imageView_.image = self.image ;
	
	UIView *darkeningView = [[UIView alloc] initWithFrame:self.view.bounds] ;
	darkeningView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8] ;
	[self.view insertSubview:darkeningView aboveSubview:imageView_] ;
	
	colorGridView_.playheadCount = 10 ;
	
	// Tap on the header to go to the capture screen
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapped:)] ;
	[headerImageView_ addGestureRecognizer:tap] ;
	}

- (void)viewDidUnload
{
	imageView_ = nil;
	headerImageView_ = nil;
	colorGridView_ = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Actions

- (IBAction)headerTapped:(UITapGestureRecognizer *)tap
	{
	if( self.playbackFinishedBlock )
		self.playbackFinishedBlock() ;
	}
@end
