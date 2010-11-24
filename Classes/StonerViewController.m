/*
 * StonerView for iPad: An eccentric visual toy.
 * Copyright 2010 by Shigeru Hagiwara (hgwr@moreslowly.jp)
 * based on Andrew Plotkin's codes
 *   http://www.eblong.com/zarf/stonerview.html
 * This program is distributed under the GPL.
 */

#import "StonerViewController.h"
#import "StonerView.h"

@implementation StonerViewController

@synthesize stonerView;

- (id)init {

    self = [super init];
    return self;
}


- (void)loadView {

    [super loadView];
    self.stonerView =
        [[StonerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = stonerView;

    [stonerView startAnimation];
}


- (void)viewDidUnload {

    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:
    (UIInterfaceOrientation)interfaceOrientation {

    return YES;
}


- (void)dealloc {

    [stonerView stopAnimation];
    [stonerView release];

    [super dealloc];
}


@end
