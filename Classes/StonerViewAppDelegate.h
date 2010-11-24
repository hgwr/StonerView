/*
 * StonerView for iPad: An eccentric visual toy.
 * Copyright 2010 by Shigeru Hagiwara (hgwr@moreslowly.jp)
 * based on Andrew Plotkin's codes
 *   http://www.eblong.com/zarf/stonerview.html
 * This program is distributed under the GPL.
 */

#import <UIKit/UIKit.h>

@class StonerViewController;

@interface StonerViewAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;
    StonerViewController *vc;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) StonerViewController *vc;

@end

