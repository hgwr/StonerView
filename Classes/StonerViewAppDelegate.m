/*
 * StonerView for iPad: An eccentric visual toy.
 * Copyright 2010 by Shigeru Hagiwara (hgwr@moreslowly.jp)
 * based on Andrew Plotkin's codes
 *   http://www.eblong.com/zarf/stonerview.html
 * This program is distributed under the GPL.
 */

#import "StonerViewAppDelegate.h"
#import "StonerViewController.h"
#import "StonerView.h"

@implementation StonerViewAppDelegate

@synthesize window;
@synthesize vc;


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    vc = [[StonerViewController alloc] init];
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window makeKeyAndVisible];
    [window addSubview:vc.view];

    return YES;
}


- (void)dealloc {

    [window release];
    [vc release];

    [super dealloc];
}


@end
