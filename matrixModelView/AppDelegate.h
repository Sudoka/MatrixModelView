//
// AppDelegate.h
// =============
// matrixModelView
//
//  AUTHOR: Song Ho Ahn (song.ahn@gmail.com)
// CREATED: 2012-04-17
// UPDATED: 2012-06-14
//
// Copyright (c) 2012 Song Ho Ahn. All rights reserved.
///////////////////////////////////////////////////////////////////////////////

#import <Cocoa/Cocoa.h>
#import "ViewGL.h"
#import "ModelGL.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    // model component
    ModelGL model;
}


@property (assign) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet ViewGL *viewGL;

// camera (view) transform controls
@property (unsafe_unretained) IBOutlet NSStepper *stepCamPosX;
@property (unsafe_unretained) IBOutlet NSStepper *stepCamPosY;
@property (unsafe_unretained) IBOutlet NSStepper *stepCamPosZ;
@property (unsafe_unretained) IBOutlet NSStepper *stepCamRotX;
@property (unsafe_unretained) IBOutlet NSStepper *stepCamRotY;
@property (unsafe_unretained) IBOutlet NSStepper *stepCamRotZ;
@property (unsafe_unretained) IBOutlet NSTextField *textCamPosX;
@property (unsafe_unretained) IBOutlet NSTextField *textCamPosY;
@property (unsafe_unretained) IBOutlet NSTextField *textCamPosZ;
@property (unsafe_unretained) IBOutlet NSTextField *textCamRotX;
@property (unsafe_unretained) IBOutlet NSTextField *textCamRotY;
@property (unsafe_unretained) IBOutlet NSTextField *textCamRotZ;

// model transform controls
@property (unsafe_unretained) IBOutlet NSStepper *stepModPosX;
@property (unsafe_unretained) IBOutlet NSStepper *stepModPosY;
@property (unsafe_unretained) IBOutlet NSStepper *stepModPosZ;
@property (unsafe_unretained) IBOutlet NSStepper *stepModRotX;
@property (unsafe_unretained) IBOutlet NSStepper *stepModRotY;
@property (unsafe_unretained) IBOutlet NSStepper *stepModRotZ;
@property (unsafe_unretained) IBOutlet NSTextField *textModPosX;
@property (unsafe_unretained) IBOutlet NSTextField *textModPosY;
@property (unsafe_unretained) IBOutlet NSTextField *textModPosZ;
@property (unsafe_unretained) IBOutlet NSTextField *textModRotX;
@property (unsafe_unretained) IBOutlet NSTextField *textModRotY;
@property (unsafe_unretained) IBOutlet NSTextField *textModRotZ;

// matrix element controls
@property (unsafe_unretained) IBOutlet NSMatrix *matModel;
@property (unsafe_unretained) IBOutlet NSMatrix *matView;
@property (unsafe_unretained) IBOutlet NSMatrix *matModelView;

// textbox for opengl calls
@property (unsafe_unretained) IBOutlet NSTextField *textViewMatrix;
@property (unsafe_unretained) IBOutlet NSTextField *textModelMatrix;

// user event handlers
- (IBAction) stepperClicked: (id)sender;
- (IBAction) resetViewMatrix: (id)sender;
- (IBAction) resetModelMatrix: (id)sender;

- (void) updateMatrixElements;
- (void) updateViewMatrixCalls;
- (void) updateModelMatrixCalls;

@end
