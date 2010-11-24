/*
 * StonerView for iPad: An eccentric visual toy.
 * Copyright 2010 by Shigeru Hagiwara (hgwr@moreslowly.jp)
 * based on Andrew Plotkin's codes
 *   http://www.eblong.com/zarf/stonerview.html
 * This program is distributed under the GPL.
 */

#import <UIKit/UIKit.h>

@class StonerView;

@interface StonerViewController : UIViewController {

    StonerView *stonerView;
}

- (id)init;

@property (nonatomic, retain) StonerView *stonerView;

@end
