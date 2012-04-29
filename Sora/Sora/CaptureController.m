//
//  CaptureController.m
//  Sora
//
//  Created by Mike Manzano on 4/28/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import "CaptureController.h"
#import "PlaybackController.h"
#import "ASAnimatedTransition.h"
#import "UIImage+Resize.h"

@interface CaptureController ()
- (void) showCamera ;
@end

@implementation CaptureController
	{
	}

#pragma mark - Properties

@synthesize showCameraOnNextAppearance = showCameraOnNextAppearance_ ;
@synthesize showLogoOnNextAppearance = showLogoOnNextAppearance_ ;

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
	}

- (void)viewDidUnload
	{
    [super viewDidUnload];
	}

- (void) viewDidAppear:(BOOL)animated
	{
	[super viewDidAppear:animated] ;
	if( self.showCameraOnNextAppearance )
		{
		self.showCameraOnNextAppearance = NO ;
		[self showCamera] ;
		}
	if( self.showLogoOnNextAppearance )
		{
		
		}
	}

#pragma mark - Display

- (void) advanceToPlaybackScreenWithPlaybackDescriptor: (NSDictionary *) patternDescriptor image: (UIImage *) image
	{
	PlaybackController *playbackController = [[PlaybackController alloc] initWithNibName:@"PlaybackController" bundle:nil] ;
	playbackController.patternDescriptor = patternDescriptor ;
	playbackController.image = image ;
	
	ASAnimatedTransition *animatedTransition = [[ASAnimatedTransition alloc] init] ;
	animatedTransition.sourceView = self.view ;
	animatedTransition.destinationView = playbackController.view ;
	animatedTransition.hostView = self.view ;
	animatedTransition.initializeAnimationBlock = ^(AnimationView *animationView, CALayer *sourceLayer, CALayer *destinationLayer)
		{
		destinationLayer.opacity = 0 ;
		} ;
	animatedTransition.performAnimationBlock = ^(AnimationView *animationView, CALayer *sourceLayer, CALayer *destinationLayer)
		{
		sourceLayer.opacity = 0 ;
		destinationLayer.opacity = 1 ;
		} ;
	animatedTransition.animationFinishedBlock = ^()
		{
		playbackController.patternDescriptor = patternDescriptor ;
		playbackController.playbackFinishedBlock =
			^{
			[self.navigationController popViewControllerAnimated:YES] ;
			[self showCamera] ;
			} ;
		[self.navigationController pushViewController:playbackController animated:NO] ;
		} ;
	[animatedTransition performTransition] ;
	}
	
- (void) showCamera
	{
	if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
		{
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init] ;
		imagePicker.delegate = self ;
		imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera ;
		imagePicker.cameraOverlayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_overlay"]] ;
		
		[self presentModalViewController:imagePicker animated:YES] ;
		}
	else
		{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your device does not have a camera" message:@"You need a camera. Duh." delegate:nil cancelButtonTitle:@"Darn" otherButtonTitles:nil] ;
		[alert show] ;
		}
	}
	
#pragma mark - Network

- (void) sendImageToServer: (UIImage *) image
	{
	dispatch_async(dispatch_get_main_queue(), ^{
		[self advanceToPlaybackScreenWithPlaybackDescriptor:nil image:image] ;
		}) ;
	}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
	{
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage] ;
	if( !image )
		image = [info objectForKey:UIImagePickerControllerOriginalImage] ;
	if( !image )
		{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not find the image you just took." message:nil delegate:nil cancelButtonTitle:@"What?" otherButtonTitles:nil] ;
		[alert show] ;
		return ;
		}
		
	[self dismissModalViewControllerAnimated:YES] ;
	
	// Scale image
	dispatch_async(dispatch_get_main_queue(), ^{
		UIImage *scaledImage = [image resizedImage:CGSizeMake(640, 960) interpolationQuality:kCGInterpolationMedium] ;
		[self sendImageToServer:scaledImage] ;
		}) ;
	}

@end
