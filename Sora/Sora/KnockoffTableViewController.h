//
//  KnockoffTableViewController.h v1.2
//  Counterless
//
//  Created by Mike Manzano on 7/31/11.
//  Copyright 2011 IVM. All rights reserved.
//
//  1.2 — no longer scrolls the screen if first responder is hidden
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


#import <UIKit/UIKit.h>


// This is a table view controller that basically does the same thing as UITableViewController only we have full control over the dimensions and manipulation of the table view. For example, UITableViewController insists on making its table view full screen and any amount of mucking around with it makes it angry. And you wouldn't like it when it's angry. This class lets us do whatever we want while UITableViewController sulks in the corner.
@interface KnockoffTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
	{
	UITableView *tableView_ ;
	}

@property( nonatomic, retain ) IBOutlet UITableView *tableView ;

- (id)initWithStyle:(UITableViewStyle)style ;
- (void) setNavigationHeader ;
- (void) setNavigationHeaderForNavigationItem: (UINavigationItem *) item ;
- (void) adjustShadowOpacities ;
@end
