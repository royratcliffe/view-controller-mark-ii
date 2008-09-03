// $Id: CustomTableViewController.h,v 1.1 2008/08/29 17:11:27 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: CustomTableViewController.h,v $
// Revision 1.1  2008/08/29 17:11:27  royratcliffe
// Initial revision
//

#import <Cocoa/Cocoa.h>

@interface CustomTableViewController : NSViewController
{
	IBOutlet NSArrayController *myTableArray;
}
@end
