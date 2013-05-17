//
// ViewGL.mm
// =========
// matrixModelView
// Controller & View component of OpenGL window
// We only implement mouse event handlers.
//
//  AUTHOR: Song Ho Ahn (song.ahn@gmail.com)
// CREATED: 2012-04-17
// UPDATED: 2013-03-01
//
// Copyright (c) 2012 Song Ho Ahn. All rights reserved.
///////////////////////////////////////////////////////////////////////////////

#import "ViewGL.h"

@implementation ViewGL



///////////////////////////////////////////////////////////////////////////////
// initialize member variables
- (void) awakeFromNib
{
    model = nil;
    //printf("awakeFromNib\n");
}



///////////////////////////////////////////////////////////////////////////////
- (void) drawRect: (NSRect)dirtyRect
{
    if(!model)
        return;
    
    model->draw();
    [[self openGLContext] flushBuffer];
}



///////////////////////////////////////////////////////////////////////////////
- (void) reshape
{
    if(!model)
        return;
    
    NSRect rect = [self bounds];
    int width = (int)rect.size.width;
    int height = (int)rect.size.height;
    model->setWindowSize(width, height);
    [self setNeedsDisplay:YES];
    
    printf("OpenGL window is resized: %d x %d\n", width, height);
}



///////////////////////////////////////////////////////////////////////////////
- (void) setModel: (ModelGL *)m
{
    model = m;
}



///////////////////////////////////////////////////////////////////////////////
// override this function returns YES, so, the class can receive mouse event
- (BOOL) acceptsFirstMouse: (NSEvent*)event
{
    return YES;
}



///////////////////////////////////////////////////////////////////////////////
// handle mouse events
- (void) mouseDown: (NSEvent*)event
{
    if(!model)
        return;

    NSPoint pos = [NSEvent mouseLocation];
    model->setMousePosition((int)pos.x, (int)-pos.y);
}

- (void) mouseUp: (NSEvent*)event
{
    if(!model)
        return;
    
    NSPoint pos = [NSEvent mouseLocation];
    model->setMousePosition((int)pos.x, (int)-pos.y);
}

- (void) rightMouseDown: (NSEvent*)event
{
    if(!model)
        return;
    
    NSPoint pos = [NSEvent mouseLocation];
    model->setMousePosition((int)pos.x, (int)-pos.y);
}

- (void) rightMouseUp: (NSEvent*)event
{
    if(!model)
        return;
    
    NSPoint pos = [NSEvent mouseLocation];
    model->setMousePosition((int)pos.x, (int)-pos.y);
}

- (void) mouseDragged: (NSEvent*)event
{
    if(!model)
        return;

    NSPoint pos = [NSEvent mouseLocation];

    model->rotateCamera((int)pos.x, (int)-pos.y);
    model->draw();
    [[self openGLContext] flushBuffer]; // swap buffers
}

- (void) rightMouseDragged:(NSEvent *)theEvent
{
    if(!model)
        return;

    NSPoint pos = [NSEvent mouseLocation];

    model->zoomCamera((int)-pos.y);
    model->draw();
    [[self openGLContext] flushBuffer]; // swap buffers
}

- (void) scrollWheel: (NSEvent*)event
{
    if(!model)
        return;
    
    NSPoint pos = [NSEvent mouseLocation];
    int delta = (int)[event deltaY];

    model->setMousePosition((int)pos.x, (int)-pos.y);
    model->zoomCamera((int)-pos.y + delta);
    
    model->draw();
    [[self openGLContext] flushBuffer]; // swap buffers
}

@end
