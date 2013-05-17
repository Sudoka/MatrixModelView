//
// ViewGL.h
// ========
// matrixModelView
// Controller & View component of OpenGL window
// We only implement mouse event handlers.
//
//  AUTHOR: Song Ho Ahn (song.ahn@gmail.com)
// CREATED: 2012-04-17
// UPDATED: 2012-06-14
//
// Copyright (c) 2012 Song Ho Ahn. All rights reserved.
///////////////////////////////////////////////////////////////////////////////

#import <AppKit/AppKit.h>
#import "ModelGL.h"


@interface ViewGL : NSOpenGLView
{
    ModelGL* model; // pointer to model component
}

// set model component
- (void) setModel: (ModelGL*)model;

@end
