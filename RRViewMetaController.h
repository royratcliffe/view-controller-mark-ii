// $Id: RRViewMetaController.h,v 1.2 2008/08/31 00:25:32 royratcliffe Exp $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: RRViewMetaController.h,v $
// Revision 1.2  2008/08/31 00:25:32  royratcliffe
// Reordered methods; more logical arrangement
//
// Revision 1.1  2008/08/29 17:10:19  royratcliffe
// Controller for meta-controlling NSViewControllers, initial revision
//

#import <AppKit/AppKit.h>

// Meta refers to a position beyond, of a higher or second-order kind. Thus, a
// meta-controller controls controllers! Hence, the view meta-controller class
// controls view controllers.
// Notice, the class does not implement a back-reference to the parent
// meta-controller. True, even though they form a tree. View paths specify leaf
// nodes. The class resolves the path by walking from root to leaf, recording
// the journey at each step. This approach obviates references to parent nodes.
// Effectively, the graph of meta-controllers "hovers" above the view
// controllers, retaining them and their view hierarchies. You address leaves on
// the meta-graph using view paths where the names of the path elements
// correspond to the nib names. That implies that you can have the same nib by
// the same name. You can but not at the same tier in the hierarchy unless you
// use a colon to add more context to the name without adding to the nib
// name. In short, name strings of the form myNib:blahBlah loads the nib file
// named myNib but uses myNib:blahBlah to uniquely identify the meta-controller
// within the graph.
@interface RRViewMetaController : NSObject
{
	NSMutableDictionary *metaControllersByName;
	NSViewController *viewController;
}

@property(retain) NSViewController *viewController;

//------------------------------------------------- Initialisers & De-Allocators

- (void)releaseViewController;
	// Releases the associated view controller and by implication also removes
	// the view controller's view from its super-view.

//-------------------------------------------------------------------- Accessors

- (NSView *)view;
	// Every meta-controller stands in the shadow of a view controller, an
	// instance of NSViewController. Every view controller associates with a
	// view. The meta-controller's -view method (this method) answers the
	// view. If not already loaded from its nib, this method also indirectly
	// does so.

//---------------------------------------- Adding to & Removing from Super-Views

- (void)addToSuperview:(NSView *)superview;
	// Adds the view linked to this meta-controller (via the view controller) to
	// the given super-view. The controlled sub-view's frame becomes equal to
	// the super-view's bounds. This is a simple approach to layout.

- (void)removeFromSuperview;
	// Removes the meta-controlled view from its super-view, but without
	// releasing the view controller.

//------------------------------------------- Naming & Removing Meta-Controllers

- (NSArray *)namesOfMetaControllers;
	// Answers all the unique names of the subordinate meta-controllers.

- (NSString *)nameOfMetaController:(RRViewMetaController *)metaController;
	// Answers the name of the given meta-controller. Assumes that the given
	// object is a direct child node of the receiving meta-controller. Returns
	// nil of not. Names are unique. Meta-controllers can only have one for each
	// subordinate meta-controller.

- (void)removeMetaController:(RRViewMetaController *)metaController;
	// Removes a meta-controller.

//---------------------------------------------- Resolving & Removing View Paths

- (NSArray *)resolveViewPath:(NSString *)viewPath;
	// Resolves a given view path answering an array of view
	// meta-controllers. The method automatically constructs any missing
	// controller elements, if any. The given path applies relatively with
	// respect to the receiver. If the path specifies sub-controllers, resolving
	// continues by recursion. Note that resolving a view path constructs the
	// corresponding meta-controllers but does not automatically load the
	// corresponding views. Accessing a view controller's view method loads the
	// view.

- (void)removeViewPath:(NSString *)viewPath;
	// Removes the meta-controller identified by the given
	// view-path. Presumably, the application has already resolved the
	// path. Otherwise, resolving herein will first construct the path before
	// removing it. The path specifies a leaf in the meta-control
	// graph. Removing releases and removes the leaf only. It does not remove
	// any elements in-between the removed leaf and the root.

@end
