// $Id: CustomTableViewController.m,v 1.1 2008/08/29 17:11:32 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: CustomTableViewController.m,v $
// Revision 1.1  2008/08/29 17:11:32  royratcliffe
// Initial revision
//

#import "CustomTableViewController.h"

@implementation CustomTableViewController

- (void)awakeFromNib
{
	[myTableArray addObjects:[NSArray arrayWithObjects:[NSDictionary dictionaryWithObject:@"Keith" forKey:@"name"], [NSDictionary dictionaryWithObject:@"Craig" forKey:@"name"], [NSDictionary dictionaryWithObject:@"Eric" forKey:@"name"], nil]];
}

@end
