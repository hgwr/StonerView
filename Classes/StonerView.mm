/*
 * StonerView for iPad: An eccentric visual toy.
 * Copyright 2010 by Shigeru Hagiwara (hgwr@moreslowly.jp)
 * based on Andrew Plotkin's codes
 *   http://www.eblong.com/zarf/stonerview.html
 * This program is distributed under the GPL.
 */

#import "StonerView.h"
#import "StonerRenderer.h"

@implementation StonerView

@synthesize animating;
@dynamic animationFrameInterval;


+ (Class)layerClass {

    return [CAEAGLLayer class];
}


- (id)initWithFrame:(CGRect)frame {

    if ((self = [super initWithFrame:frame])) {
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;

        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties =
            [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithBool:FALSE],
                          kEAGLDrawablePropertyRetainedBacking,
                          kEAGLColorFormatRGBA8,
                          kEAGLDrawablePropertyColorFormat, nil];

        renderer = [[StonerRenderer alloc] init];
        if (!renderer) {
            [self release];
            return nil;
        }

        animating = FALSE;
        animationFrameInterval = 1;
        displayLink = nil;
    }

    return self;
}


- (void)drawView:(id)sender {

    [renderer render];
}


- (void)layoutSubviews {

    [renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
}


- (NSInteger)animationFrameInterval {

    return animationFrameInterval;
}


- (void)setAnimationFrameInterval:(NSInteger)frameInterval {

    if (frameInterval >= 1) {
        animationFrameInterval = frameInterval;
        if (animating) {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}


- (void)startAnimation {

    if (!animating) {
        displayLink =
            [NSClassFromString(@"CADisplayLink")
                displayLinkWithTarget:self selector:@selector(drawView:)];
        [displayLink setFrameInterval:animationFrameInterval];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                          forMode:NSDefaultRunLoopMode];
        animating = TRUE;
    }
}


- (void)stopAnimation {

    if (animating) {
        [displayLink invalidate];
        displayLink = nil;
        animating = FALSE;
    }
}


- (void)dealloc {

    [renderer release];
    [super dealloc];
}


@end
