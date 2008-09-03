// $Id: CustomImageViewController.h,v 1.1 2008/08/29 17:11:16 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: CustomImageViewController.h,v $
// Revision 1.1  2008/08/29 17:11:16  royratcliffe
// Initial revision
//

#import <Cocoa/Cocoa.h>

@interface CustomImageViewController : NSViewController
{
	IBOutlet NSImageView *imageView;
	IBOutlet NSTextField *textView;
		// Text view is actually a text Field! Apple's original sample code
		// misnames the instance variable. Changing it would be good, to
		// textField, but not possible without changing the nib. But we intend
		// to leave the nibs completely unchanged, by design!
}

- (IBAction)openImageAction:(id)sender;

@end
