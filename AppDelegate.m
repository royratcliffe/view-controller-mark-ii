// $Id: AppDelegate.m,v 1.1 2008/08/28 15:56:11 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: AppDelegate.m,v $
// Revision 1.1  2008/08/28 15:56:11  royratcliffe
// Initial revision
//

#import "AppDelegate.h"
#import "MyWindowController.h"

@implementation AppDelegate

- (IBAction)newDocument:(id)sender
{
	// The MainMenu nib's main menu sends this action when you select File New,
	// or Command+N. The menu item target is the first responder. This falls
	// through the Responder Chain until it finally hits AppDelegate. Answer by
	// constructing the window controller, if not already existing, and show it.
	if (myWindowController == nil)
		myWindowController = [[MyWindowController alloc] initWithWindowNibName:@"TestWindow"];
	[myWindowController showWindow:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	// By virtue of AppDelegate being the application's delegate, it
	// automatically receives application notifications. How kind. Respond by
	// sending the -newDocument: action, just as if the user pressed Command+N.
	[self newDocument:self];
}

@end
