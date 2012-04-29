//
//  KnockoffTableViewController.m v1.2
//  Counterless
//
//  Created by Mike Manzano on 7/31/11.
//  Copyright 2011 IVM. All rights reserved.
//
// See: http://cocoawithlove.com/2009/03/recreating-uitableviewcontroller-to.html
//
// Portions of this code are:
//
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

#import "KnockoffTableViewController.h"
#import "UIView+ResignFirstResponder.h"
#import "ShadowView.h"

@interface KnockoffTableViewController (Private)
- (void)registerForKeyboardNotifications ;
- (void)unregisterFromKeyboardNotifications ;
@end

@implementation KnockoffTableViewController
	{
	ShadowView *topShadowView_ ;
	ShadowView *bottomShadowView_ ;
	}

#pragma mark - Properties

@synthesize tableView=tableView_ ;


#pragma mark - Instance

- (id)initWithStyle:(UITableViewStyle)style
	{
    self = [super initWithNibName:nil bundle:nil] ;
    if (self)
		{
		}
    return self;
	}

- (void) dealloc
	{
	self.tableView = nil ;
	topShadowView_ = nil ;
	bottomShadowView_ = nil ;
	}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
	{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
		{
		}
    return self;
	}

- (void)didReceiveMemoryWarning
	{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
	}

#pragma mark - Display

- (void) adjustShadowOpacities
	{
//	NSLog(@"b:%@ — cz:%@", NSStringFromCGRect(self.tableView.bounds), NSStringFromCGSize(self.tableView.contentSize)) ;
	if( self.tableView.bounds.origin.y > 0 )
		topShadowView_.hidden = NO ;
	else
		topShadowView_.hidden = YES ;
		
	if( self.tableView.bounds.origin.y + self.tableView.bounds.size.height >= self.tableView.contentSize.height )
		bottomShadowView_.hidden = YES ;
	else
		bottomShadowView_.hidden = NO ;
		
	[self.view bringSubviewToFront:topShadowView_] ;
	[self.view bringSubviewToFront:bottomShadowView_] ;
	}
	
#pragma mark - View lifecycle

- (void)loadView
	{
    if (self.nibName)
		{
        [super loadView];
        NSAssert(self.tableView != nil, @"NIB file did not set tableView property.");
        return;
		}
    
    UITableView *newTableView =
	[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] ;
    self.view = newTableView;
    self.tableView = newTableView;
	newTableView.delegate = self ;
	newTableView.dataSource = self ;
	}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
	{
    [super viewDidLoad];

	// Add bottom and top shadow view
	topShadowView_ = [[ShadowView alloc] initWithFrame:CGRectZero] ;
	bottomShadowView_ = [[ShadowView alloc] initWithFrame:CGRectZero] ;
	bottomShadowView_.topShadow = YES ;
	topShadowView_.hidden = YES ;
	bottomShadowView_.hidden = YES ;
	[self.view addSubview:topShadowView_] ;
	[self.view addSubview:bottomShadowView_] ;
	[self.view bringSubviewToFront:topShadowView_] ;
	[self.view bringSubviewToFront:bottomShadowView_] ;
	}
	
- (void) viewDidUnload
	{
	[super viewDidUnload] ;
	}

- (void)viewDidAppear:(BOOL)animated
	{
	[super viewDidAppear:animated] ;
	[self adjustShadowOpacities] ;
	[self.tableView flashScrollIndicators] ;
	}

- (void)viewWillAppear:(BOOL)animated	
	{
	[super viewWillAppear:animated] ;
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated] ;
	[self.tableView reloadData] ;
	[self registerForKeyboardNotifications] ;
	
	// Get notified when tableview's frame has changed
	[self.tableView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:NULL] ;
	}

- (void)viewWillDisappear:(BOOL)animated
	{
	[super viewWillDisappear:animated] ;
	[self unregisterFromKeyboardNotifications] ;
	[self.tableView removeObserver:self forKeyPath:@"frame"] ;
	}

- (void) viewDidDisappear:(BOOL)animated
	{
	[super viewDidDisappear:animated] ;
	}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
	{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
	}

#pragma mark - Handling Keyboard Obscuring of UITextFields
// http://developer.apple.com/library/ios/#documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
// http://cocoawithlove.com/2008/10/sliding-uitextfields-around-to-avoid.html
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
	{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
	}

- (void) unregisterFromKeyboardNotifications
	{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil] ;
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil] ;
	}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
	{
// The desired gutter between the keyboard and field
#define KEYBOARD_FIELD_GUTTER 40
	
	// Get the active field
	UIView *activeField = (UIView *) [[[UIApplication sharedApplication] keyWindow]findFirstResponder] ;
	if( activeField )
		{
		// Do nothing if this field is hidden
		if( activeField.hidden )
			return ;
		
		NSDictionary* info = [aNotification userInfo];
		CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

		// Get the accessory view height
		CGRect keyboardAccessoryFrame = CGRectZero ;
		UIView *firstResponder = [[UIApplication sharedApplication].keyWindow findFirstResponder] ;
		
		if( firstResponder )
			{
			if( [firstResponder isKindOfClass:[UITextField class]] )
				{
				keyboardAccessoryFrame = ((UITextField*)firstResponder).inputAccessoryView.frame ;
				}
			}
		
		// This only works if the table view is flush with the bottom of the view. Should change it to factor in the view's size vs. the table view's size
		UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
		self.tableView.contentInset = contentInsets;
		self.tableView.scrollIndicatorInsets = contentInsets;
		
		// If active text field is hidden by keyboard, scroll it so it's visible
		// Your application might not need or want this behavior.
		
		// frameUnobscuredByKeyboard isn't quite "visibleFrame". It's just the area that isn't covered by the keyboard. There may be, for example, a navigation bar obscuring part of this frame
		CGRect frameUnobscuredByKeyboard = self.view.frame;
		frameUnobscuredByKeyboard.size.height -= kbSize.height;
		CGRect fieldFrameInViewCoordinates = [activeField convertRect:activeField.frame toView:self.view] ;
		if (!CGRectContainsPoint(frameUnobscuredByKeyboard, fieldFrameInViewCoordinates.origin) ) 
			{
#warning this calc is a hack I think
			CGPoint scrollPoint = CGPointMake(0.0, (fieldFrameInViewCoordinates.origin.y+fieldFrameInViewCoordinates.size.height+KEYBOARD_FIELD_GUTTER+keyboardAccessoryFrame.size.height*2)-(kbSize.height));
			[self.tableView setContentOffset:scrollPoint animated:YES] ;
			}
		} // if activeField
	}

// Called when the UIKeyboardWillHideNotification is sent
// NOTE: I made modifications to the code to always check the keyboard size instead of saving a scroll offset in -keyboardWasShown. Theoretically, this handles the case of the device being rotated while the keyboard is shown, but I haven't tested it since docBeat is a portrait only app. MRM
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
	{
	// Get the active field
	UIView *activeField = (UIView *) [[[UIApplication sharedApplication] keyWindow]findFirstResponder] ;
	if( activeField )
		{
		UIEdgeInsets contentInsets = UIEdgeInsetsZero;
		[UIView beginAnimations:@"resize tv" context:NULL] ;
		[UIView setAnimationDuration:0.3] ; 
		[UIView setAnimationDelay:0.1] ; // For that nice "hey wait up Mr. Keyboard!" feel
		self.tableView.contentInset = contentInsets;
		self.tableView.scrollIndicatorInsets = contentInsets;
		[UIView commitAnimations] ;
		}
	}

#pragma mark - UIViewController

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
	{
	[super setEditing:editing animated:animated] ;
	[self.tableView setEditing:editing animated:animated] ;
	}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
	{
	return nil ;
	}
	
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
	{
	return 0 ;
	}

#warning this is so dirty I had to put porn on when my mom walked in

- (void) setNavigationHeaderForNavigationItem: (UINavigationItem *) item
	{
	NSAssert( item , @"item is nil" ) ;

	static NSInteger customTitleViewTag = 89012 ;
	
	UILabel *label ;
	if( item.titleView.tag == customTitleViewTag )
		label = (UILabel *) item.titleView ;
	else
		{
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont fontWithName:@"HelveticaNeue" size:20] ;
		label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor whiteColor];
		label.tag = customTitleViewTag ;

		item.titleView = label;
		}

	CGSize newSize = [self.title sizeWithFont:label.font] ;
	CGRect newFrame = label.frame ;
	newFrame.size.width = newSize.width ;
	label.frame = newFrame ;

	label.text = self.title ;
	}

- (void) setNavigationHeader
	{
	[self setNavigationHeaderForNavigationItem:self.navigationItem] ;
	}
	
- (void) setTitle:(NSString *)title
	{
	[super setTitle:title] ;
	[self setNavigationHeader] ;
	}
	
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
	{
	[self adjustShadowOpacities] ;
	}
	
#pragma mark - KVO

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
	{
	if( [keyPath isEqualToString:@"frame"] && object == self.tableView )
		{
		static float shadowHeight = 6 ;
		CGRect frame = self.tableView.frame ;
		topShadowView_.frame = CGRectMake(0, frame.origin.y, frame.size.width, shadowHeight) ;
		bottomShadowView_.frame = CGRectMake(0, frame.origin.y + frame.size.height - shadowHeight, frame.size.width, shadowHeight) ;
		[self adjustShadowOpacities] ;
		}
	}

@end
