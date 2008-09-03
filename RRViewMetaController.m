// $Id: RRViewMetaController.m,v 1.2 2008/08/31 00:25:32 royratcliffe Exp $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: RRViewMetaController.m,v $
// Revision 1.2  2008/08/31 00:25:32  royratcliffe
// Reordered methods; more logical arrangement
//
// Revision 1.1  2008/08/29 17:10:19  royratcliffe
// Controller for meta-controlling NSViewControllers, initial revision
//

#import "RRViewMetaController.h"

@implementation RRViewMetaController

@synthesize viewController;

// View-path delimiter. Dot or slash? Dot conjures up one concrete concept of
// paths, KVC key-paths for example. Slash evokes yet another, e.g. file system
// nodes. Perhaps there's no "right" choice. It could be an option but that
// defeats convention over configuration principles. Decision: use dot. Slash
// brings with it some extra baggage, e.g. slash by itself implies root; slash
// at the end implies directory. Dot has no such implications. Dots at the start
// and end of a dot-delimited path carries notions of error, rather than some
// cryptic interpretation of root and directory leaf. That matches view-path
// paradigm. Dots should not start and end view paths.
static NSString *const kViewPathDelimiter = @".";
static NSString *const kViewNameDelimiter = @":";

//------------------------------------------------------------------------------
#pragma mark Initialisers & De-Allocators
//------------------------------------------------------------------------------

- (id)init
{
	if ((self = [super init]))
	{
		metaControllersByName = [[NSMutableDictionary alloc] init];
		// Does the class need to initialise the viewController instance
		// variable? Do all instance variables automatically receive nil values
		// on initialisation of an instance? Answer: yes. See Discussion of
		// NSObject's alloc method: memory of all instance variables is set to
		// 0.
	}
	return self;
}

- (void)dealloc
{
	[metaControllersByName release];
	[self releaseViewController];
	[super dealloc];
}

- (void)releaseViewController
{
	[self removeFromSuperview];
	[self setViewController:nil];
}

//------------------------------------------------------------------------------
#pragma mark Accessors
//------------------------------------------------------------------------------

- (NSView *)view
{
	return [[self viewController] view];
}

//------------------------------------------------------------------------------
#pragma mark Adding to & Removing from Super-Views
//------------------------------------------------------------------------------

- (void)addToSuperview:(NSView *)superview
{
	NSView *subview = [self view];
	[superview addSubview:subview];
	[subview setFrame:[superview bounds]];
}

- (void)removeFromSuperview
{
	[[self view] removeFromSuperview];
}

//------------------------------------------------------------------------------
#pragma mark Naming & Removing Meta-Controllers
//------------------------------------------------------------------------------

- (NSArray *)namesOfMetaControllers
{
	return [metaControllersByName allKeys];
}

- (NSString *)nameOfMetaController:(RRViewMetaController *)metaController
{
	NSArray *names = [metaControllersByName allKeysForObject:metaController];
	return [names count] ? [names objectAtIndex:0] : nil;
}

- (void)removeMetaController:(RRViewMetaController *)metaController
{
	[metaControllersByName removeObjectForKey:[self nameOfMetaController:metaController]];
}

//------------------------------------------------------------------------------
#pragma mark Resolving & Removing View Paths
//------------------------------------------------------------------------------

- (NSArray *)resolveViewPath:(NSString *)viewPath
{
	// Cut the view path into its constituent pieces. Delimiter marks divide
	// view controller meta-names. The names always correspond to nib names, by
	// convention.
	// If the string contains at least one delimiter, the number of components
	// will be two or more. Otherwise equal to one, where one may also amount to
	// an empty (blank) name. Blank is a valid name although no good will come
	// when AppKit tries to initWithNibName:@"" on a view controller!
	NSRange delimiter = [viewPath rangeOfString:kViewPathDelimiter];
	if (delimiter.location == NSNotFound)
	{
		delimiter.location = [viewPath length];
	}
	NSString *name = [viewPath substringToIndex:delimiter.location];
	RRViewMetaController *metaController = [metaControllersByName objectForKey:name];
	if (metaController == nil)
	{
		// Here is a potential snag. The new nib specifies the owner, a view
		// controller subclass presumably. How, without accessing the nib, can
		// we instantiate the right class? In order to instantiate a view
		// controller sub-class as the nib owner, this method requires the class
		// name. By convention use the nib name plus Controller. This is where
		// we choose convention over configuration; it's a useful principle,
		// solves quite a few problems.
		metaController = [[RRViewMetaController alloc] init];
		Class viewControllerClass = NSClassFromString([name stringByAppendingString:@"Controller"]);
		if (viewControllerClass == nil)
		{
			viewControllerClass = [NSViewController class];
		}
		[metaController setViewController:[[[viewControllerClass alloc] initWithNibName:[[name componentsSeparatedByString:kViewNameDelimiter] objectAtIndex:0] bundle:nil] autorelease]];
		[metaControllersByName setObject:metaController forKey:name];
		[metaController release];
	}
	// Finally, at this point, after having resolved the first name, form the
	// answer as an array. Then, if we found a delimiter, append the other
	// meta-controllers. The final result gives an array of meta-controllers
	// representing the given view-path: for each view-path name element in,
	// gives one meta-controller out.
	NSArray *metaControllers = [NSArray arrayWithObject:metaController];
	if (delimiter.length)
	{
		metaControllers = [metaControllers arrayByAddingObjectsFromArray:[metaController resolveViewPath:[viewPath substringFromIndex:NSMaxRange(delimiter)]]];
	}
	return metaControllers;
}

- (void)removeViewPath:(NSString *)viewPath
{
	// Removing could be simpler if resolving preserved the names as well as the
	// meta-controllers. Having the name would elimitate a reverse look-up on
	// the meta-controller to be removed in the context of the enclosing
	// meta-controller.
	NSArray *metaControllers = [self resolveViewPath:viewPath];
	NSUInteger count = [metaControllers count];
	if (count == 1)
	{
		[self removeMetaController:[metaControllers lastObject]];
	}
	else if (count >= 2)
	{
		[[metaControllers objectAtIndex:count - 2] removeMetaController:[metaControllers lastObject]];
	}
}

@end
