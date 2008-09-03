// $Id: AppDelegate.h,v 1.1 2008/08/28 15:55:56 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: AppDelegate.h,v $
// Revision 1.1  2008/08/28 15:55:56  royratcliffe
// Initial revision
//

#import <Cocoa/Cocoa.h>

@class MyWindowController;

@interface AppDelegate : NSObject
{
	MyWindowController *myWindowController;
}
@end
