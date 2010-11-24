/*
 * StonerView for iPad: An eccentric visual toy.
 * Copyright 2010 by Shigeru Hagiwara (hgwr@moreslowly.jp)
 * based on Andrew Plotkin's codes
 *   http://www.eblong.com/zarf/stonerview.html
 * This program is distributed under the GPL.
 */

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface StonerRenderer : NSObject {
@private
    EAGLContext *context;

    GLint backingWidth;
    GLint backingHeight;

    GLuint defaultFramebuffer, colorRenderbuffer;
}

- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

@end
