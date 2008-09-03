// $Id: CustomVideoViewController.m,v 1.1 2008/08/29 17:11:42 royratcliffe Exp royratcliffe $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
// All rights reserved
//
//------------------------------------------------------------------------------
//
// $Log: CustomVideoViewController.m,v $
// Revision 1.1  2008/08/29 17:11:42  royratcliffe
// Initial revision
//

#import "CustomVideoViewController.h"

#import <QTKit/QTKit.h>

@implementation CustomVideoViewController

- (void)awakeFromNib
{
	// The controller's view is of class QTMovieView, a sub-class of NSView
	// found in QTKit.
	QTMovie *movie = [QTMovie movieNamed:@"adam" error:NULL];
	[movie setAttribute:[NSNumber numberWithBool:NO] forKey:QTMovieEditableAttribute];
	[movie setAttribute:[NSNumber numberWithBool:YES] forKey:QTMovieLoopsBackAndForthAttribute];
	QTMovieView *movieView = (QTMovieView *)[self view];
	[movieView setMovie:movie];
	[movieView setPreservesAspectRatio:YES];
	[movieView play:self];
}

@end
