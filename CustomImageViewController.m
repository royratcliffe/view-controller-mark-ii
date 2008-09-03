// $Id: CustomImageViewController.m,v 1.1 2008/08/29 17:11:23 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: CustomImageViewController.m,v $
// Revision 1.1  2008/08/29 17:11:23  royratcliffe
// Initial revision
//

#import "CustomImageViewController.h"

@implementation CustomImageViewController

- (void)configureImage:(NSString *)imagePathString
{
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:imagePathString];
	[imageView setImage:image];
	[image release];
	[textView setStringValue:[imagePathString lastPathComponent]];
}

- (void)awakeFromNib
{
	[self configureImage:[[NSBundle mainBundle] pathForImageResource:@"LakeDonPedro"]];
}

#pragma mark Opening Images

- (void)openPanelDidEnd:(NSOpenPanel *)panel returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
	if (returnCode == NSOKButton)
	{
		if ([[panel URL] isFileURL])
		{
			[self configureImage:[[panel URL] path]];
		}
	}
}

- (IBAction)openImageAction:(id)sender
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel beginSheetForDirectory:@"/Library/Desktop Pictures" file:nil types:[NSArray arrayWithObjects:@"jpg", nil] modalForWindow:[[self view] window] modalDelegate:self didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:) contextInfo:NULL];
}

// See below. You can catch when the view loads by overriding this view
// controller method. The view has not been connected yet. The meta-controller
// sends -view to the view controller; the view controller loads the view from
// the nib and establishes outlet connections. At that point, the view
// controller or your subclass receives -setView:newView. Invoke the super-class
// implementation to complete the connection first.

- (void)setView:(NSView *)view
{
	[super setView:view];
}

@end
