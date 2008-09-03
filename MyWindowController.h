// $Id: MyWindowController.h,v 1.1 2008/08/28 15:56:17 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: MyWindowController.h,v $
// Revision 1.1  2008/08/28 15:56:17  royratcliffe
// Initial revision
//

#import <Cocoa/Cocoa.h>

// forward declaration, see RRViewMetaController.h
@class RRViewMetaController;

@interface MyWindowController : NSWindowController
{
	IBOutlet NSView *myTargetView;
	NSViewController *viewController;
		// TestWindow.nib contains bindings to this instance variable's "title"
		// and "representedObject" property. Rather than naming it
		// myCustomViewController, as does the Apple sample code, name the
		// instance variable by its KVC key. Doing so saves an accessor.
	RRViewMetaController *viewMetaController;
}

- (IBAction)viewChoicePopupAction:(id)sender;

@end
