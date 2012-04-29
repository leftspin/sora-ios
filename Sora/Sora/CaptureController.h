//
//  CaptureController.h
//  Sora
//
//  Created by Mike Manzano on 4/28/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptureController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property( assign, nonatomic ) BOOL showCameraOnNextAppearance ;
@property( assign, nonatomic ) BOOL showLogoOnNextAppearance ;
@end
