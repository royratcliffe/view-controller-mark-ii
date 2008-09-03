// $Id: MyWindowController.m,v 1.1 2008/08/28 15:56:24 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: MyWindowController.m,v $
// Revision 1.1  2008/08/28 15:56:24  royratcliffe
// Initial revision
//

#import "MyWindowController.h"
#import "RRViewMetaController.h"

@implementation MyWindowController

// View tags and nib names. The enumerators and strings align so that indexing
// the nib names by view tag specifies the required nib.
enum
{
	kImageView,
	kTableView,
	kVideoView,
	kCameraView
};
static NSString *const kNibNames[] =
{
	@"CustomImageView",
	@"CustomTableView",
	@"CustomVideoView",
	@"CustomCameraView",
};

- (void)changeViewController:(NSInteger)whichViewTag
{
	// for KVO
	[self willChangeValueForKey:@"viewController"];
	
	// lazy construction
	if (viewMetaController == nil)
	{
		viewMetaController = [[RRViewMetaController alloc] init];
	}
	
	// remove outgoing
	NSArray *names = [viewMetaController namesOfMetaControllers];
	if ([names count])
	{
		[viewMetaController removeViewPath:[names objectAtIndex:0]];
	}
	
	// Interesting to note that there are only three custom view controllers,
	// i.e. NSViewController sub-classes. The fourth for iSight Camera is
	// missing. The meta-controller falls back to using a plain old
	// NSViewController by default. So no problem. That's exactly what's
	// required.
	NSArray *metaControllers = [viewMetaController resolveViewPath:kNibNames[whichViewTag]];
	
	// add incoming
	viewController = [[metaControllers lastObject] viewController];
	[[metaControllers lastObject] addToSuperview:myTargetView];
	
	// set up title and represented object
	[viewController setTitle:kNibNames[whichViewTag]];
	[viewController setRepresentedObject:[NSNumber numberWithUnsignedInteger:[[[viewController view] subviews] count]]];
	
	// for KVO
	[self didChangeValueForKey:@"viewController"];
}

- (void)awakeFromNib
{
	[self changeViewController:kImageView];
}

- (IBAction)viewChoicePopupAction:(id)sender
{
	// TestWindow nib connects action -viewChoicePopupAction: to the window
	// controller. MyWindowController is the nib's owner. The
	// Image-Table-Video-Camera pop-up button sends this action to the nib
	// owner. The window controller responds by switching view and view
	// controller.
	[self changeViewController:[sender selectedTag]];
}

@end
