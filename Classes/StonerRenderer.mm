/*
 * StonerView for iPad: An eccentric visual toy.
 * Copyright 2010 by Shigeru Hagiwara (hgwr@moreslowly.jp)
 * based on Andrew Plotkin's codes
 *   http://www.eblong.com/zarf/stonerview.html
 * This program is distributed under the GPL.
 */

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import "StonerRenderer.h"
#import "view.h"
#import "move.h"

@implementation StonerRenderer


- (id)init {

    if ((self = [super init])) {
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];

        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }

        glGenFramebuffersOES(1, &defaultFramebuffer);
        glGenRenderbuffersOES(1, &colorRenderbuffer);
        glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES,
                                     GL_COLOR_ATTACHMENT0_OES,
                                     GL_RENDERBUFFER_OES,
                                     colorRenderbuffer);
        
        if (!init_move()) {
            [self release];
            return nil;
        }
        setup_window();
    }

    return self;
}


- (void)render {

    [EAGLContext setCurrentContext:context];

    glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
    glViewport(0, 0, backingWidth, backingHeight);

    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    win_draw();
    move_increment();

    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}


- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer {	

    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES,
                                    GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES,
                                    GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);

    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES)
        != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"Failed to make complete framebuffer object %x",
              glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }

    win_reshape(backingWidth, backingHeight);
    
    return YES;
}


- (void)dealloc {

    if (defaultFramebuffer) {
        glDeleteFramebuffersOES(1, &defaultFramebuffer);
        defaultFramebuffer = 0;
    }
    if (colorRenderbuffer) {
        glDeleteRenderbuffersOES(1, &colorRenderbuffer);
        colorRenderbuffer = 0;
    }
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];

    [context release];
    context = nil;

    [super dealloc];
}

@end
