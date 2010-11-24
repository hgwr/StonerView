/*
 * StonerView for iPad: An eccentric visual toy.
 * Copyright 2010 by Shigeru Hagiwara (hgwr@moreslowly.jp)
 * based on Andrew Plotkin's codes
 *   http://www.eblong.com/zarf/stonerview.html
 * This program is distributed under the GPL.
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class StonerRenderer;

@interface StonerView : UIView {    
@private
    StonerRenderer *renderer;

    BOOL animating;
    NSInteger animationFrameInterval;
    id displayLink;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (id)initWithFrame:(CGRect)frame;
- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView:(id)sender;

@end
