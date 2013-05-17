//
// AppDelegate.m
// =============
// matrixModelView
//
//  AUTHOR: Song Ho Ahn (song.ahn@gmail.com)
// CREATED: 2012-04-17
// UPDATED: 2012-06-14
//
// Copyright (c) 2012 Song Ho Ahn. All rights reserved.
///////////////////////////////////////////////////////////////////////////////

#import "AppDelegate.h"
#import <sstream>

@implementation AppDelegate

@synthesize window;
@synthesize viewGL;
@synthesize stepCamPosX;
@synthesize stepCamPosY;
@synthesize stepCamPosZ;
@synthesize stepCamRotX;
@synthesize stepCamRotY;
@synthesize stepCamRotZ;
@synthesize textCamPosX;
@synthesize textCamPosY;
@synthesize textCamPosZ;
@synthesize textCamRotX;
@synthesize textCamRotY;
@synthesize textCamRotZ;
@synthesize stepModPosX;
@synthesize stepModPosY;
@synthesize stepModPosZ;
@synthesize stepModRotX;
@synthesize stepModRotY;
@synthesize stepModRotZ;
@synthesize textModPosX;
@synthesize textModPosY;
@synthesize textModPosZ;
@synthesize textModRotX;
@synthesize textModRotY;
@synthesize textModRotZ;
@synthesize matModelView;
@synthesize textViewMatrix;
@synthesize textModelMatrix;
@synthesize matModel;
@synthesize matView;


///////////////////////////////////////////////////////////////////////////////
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // first, tell view module which is the model component 
    [viewGL setModel:&model];
    
    // OpenGL RC should be ready at this point, init OpenGL states here
    model.init();

    // get size of opengl window, and pass it to model component
    NSRect rect = [viewGL bounds];
    model.setWindowSize((int)rect.size.width, (int)rect.size.height);    

    // init transform values
    // positions are range from -10 to 10, and rotations are range from -360 to
    // 360 in degree. The default values are set to NSStepper controls in IB.
    [textCamPosX setIntValue:[stepCamPosX intValue]];
    [textCamPosY setIntValue:[stepCamPosY intValue]];
    [textCamPosZ setIntValue:[stepCamPosZ intValue]];
    [textCamRotX setIntValue:[stepCamRotX intValue]];
    [textCamRotY setIntValue:[stepCamRotY intValue]];
    [textCamRotZ setIntValue:[stepCamRotZ intValue]];

    [textModPosX setIntValue:[stepModPosX intValue]];
    [textModPosY setIntValue:[stepModPosY intValue]];
    [textModPosZ setIntValue:[stepModPosZ intValue]];
    [textModRotX setIntValue:[stepModRotX intValue]];
    [textModRotY setIntValue:[stepModRotY intValue]];
    [textModRotZ setIntValue:[stepModRotZ intValue]];

    // set all opengl transform matrices
    model.setViewMatrix([stepCamPosX intValue],
                        [stepCamPosY intValue],
                        [stepCamPosZ intValue],
                        [stepCamRotX intValue],
                        [stepCamRotY intValue],
                        [stepCamRotZ intValue]);
    model.setModelMatrix([stepModPosX intValue],
                         [stepModPosY intValue],
                         [stepModPosZ intValue],
                         [stepModRotX intValue],
                         [stepModRotY intValue],
                         [stepModRotZ intValue]);

    // update textboxes of OpenGL calls
    [self updateViewMatrixCalls];
    [self updateModelMatrixCalls];

    // init 3 matrix controls (view, model, modelview)
    [self updateMatrixElements];

    // draw once
    model.draw();
    [[viewGL openGLContext] flushBuffer];   // swap opengl framebuffers
}



///////////////////////////////////////////////////////////////////////////////
- (id) init
{
    self = [super init];
    if(self != nil)
    {
        //printf("Initializing AppDelegate.\n");
    }
    return self;
}



///////////////////////////////////////////////////////////////////////////////
- (void) awakeFromNib
{
    //printf("awakeFromNib\n");
}



///////////////////////////////////////////////////////////////////////////////
- (void) applicationWillTerminate: (NSNotification*)notification
{
    //printf("will terminate\n");
}



///////////////////////////////////////////////////////////////////////////////
- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication*) application
{
    //printf("applicationShouldTerminateAfterLastWindowClosed\n");
    // terminate app
    return YES;
}



///////////////////////////////////////////////////////////////////////////////
//- (IBAction) controlTextDidChange: (NSNotification*) notification
//{
//    printf("controlTextChanged\n");
//}



///////////////////////////////////////////////////////////////////////////////
- (IBAction) stepperClicked: (id)sender
{
    int value = [sender intValue];
    
    if(sender == stepCamPosX)
    {
        [textCamPosX setIntValue:value];
        model.setCameraX(value);
    }
    else if(sender == stepCamPosY)
    {
        [textCamPosY setIntValue:value];
        model.setCameraY(value);
    }
    else if(sender == stepCamPosZ)
    {        
        [textCamPosZ setIntValue:value];
        model.setCameraZ(value);
    }
    else if(sender == stepCamRotX)
    {
        [textCamRotX setIntValue:value];
        model.setCameraAngleX(value);
    }
    else if(sender == stepCamRotY)
    {
        [textCamRotY setIntValue:value];
        model.setCameraAngleY(value);
    }
    else if(sender == stepCamRotZ)
    {
        [textCamRotZ setIntValue:value];
        model.setCameraAngleZ(value);
    }
    else if(sender == stepModPosX)
    {
        [textModPosX setIntValue:value];
        model.setModelX(value);
    }
    else if(sender == stepModPosY)
    {
        [textModPosY setIntValue:value];
        model.setModelY(value);
    }
    else if(sender == stepModPosZ)
    {
        [textModPosZ setIntValue:value];
        model.setModelZ(value);
    }
    else if(sender == stepModRotX)
    {
        [textModRotX setIntValue:value];
        model.setModelAngleX(value);
    }
    else if(sender == stepModRotY)
    {
        [textModRotY setIntValue:value]; 
        model.setModelAngleY(value);
    }
    else if(sender == stepModRotZ)
    {
        [textModRotZ setIntValue:value];
        model.setModelAngleZ(value);
    }
    
    [self updateViewMatrixCalls];
    [self updateModelMatrixCalls];
    [self updateMatrixElements];
    
    model.draw();
    [[viewGL openGLContext] flushBuffer]; // swap OpenGL framebuffers
    //printf("stepper clicked.\n");
}



///////////////////////////////////////////////////////////////////////////////
- (void) resetViewMatrix: (id)sender
{
    [textCamPosX setIntValue:0];
    [textCamPosY setIntValue:0];
    [textCamPosZ setIntValue:10];
    [textCamRotX setIntValue:0];
    [textCamRotY setIntValue:0];
    [textCamRotZ setIntValue:0];
    [stepCamPosX setIntValue:0];
    [stepCamPosY setIntValue:0];
    [stepCamPosZ setIntValue:10];
    [stepCamRotX setIntValue:0];
    [stepCamRotY setIntValue:0];
    [stepCamRotZ setIntValue:0];

    // update opengl view matrix
    model.setViewMatrix(0, 0, 10, 0, 0, 0);

    [self updateViewMatrixCalls];
    [self updateMatrixElements];

    // redraw opengl scene
    model.draw();
    [[viewGL openGLContext] flushBuffer];
}



///////////////////////////////////////////////////////////////////////////////
- (void) resetModelMatrix: (id)sender
{
    [textModPosX setIntValue:0];
    [textModPosY setIntValue:0];
    [textModPosZ setIntValue:0];
    [textModRotX setIntValue:0];
    [textModRotY setIntValue:0];
    [textModRotZ setIntValue:0];
    [stepModPosX setIntValue:0];
    [stepModPosY setIntValue:0];
    [stepModPosZ setIntValue:0];
    [stepModRotX setIntValue:0];
    [stepModRotY setIntValue:0];
    [stepModRotZ setIntValue:0];

    // update opengl model matrix
    model.setModelMatrix(0, 0, 0, 0, 0, 0);

    [self updateModelMatrixCalls];
    [self updateMatrixElements];

    // redraw opengl scene
    model.draw();
    [[viewGL openGLContext] flushBuffer];
}



///////////////////////////////////////////////////////////////////////////////
- (void) updateMatrixElements
{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setFormat:@"#0.00"];
    NSString* formattedStr;

    const float* viewElements = model.getViewMatrixElements();
    const float* modelElements = model.getModelMatrixElements();
    const float* modelViewElements = model.getModelViewMatrixElements();

    for(int i = 0; i < 4; ++i)
    {
        for(int j = 0; j < 4; ++j)
        {
            // view matrix
            formattedStr = [formatter stringFromNumber:[NSNumber numberWithFloat:viewElements[i*4+j]]];
            [[matView cellAtRow:i column:j] setStringValue:formattedStr];

            // model matrix
            formattedStr = [formatter stringFromNumber:[NSNumber numberWithFloat:modelElements[i*4+j]]];
            [[matModel cellAtRow:i column:j] setStringValue:formattedStr];

            // modelview matrix
            formattedStr = [formatter stringFromNumber:[NSNumber numberWithFloat:modelViewElements[i*4+j]]];
            [[matModelView cellAtRow:i column:j] setStringValue:formattedStr];
        }
    }    
}



///////////////////////////////////////////////////////////////////////////////
- (void) updateViewMatrixCalls
{
    // values are negated and order is reversed because it is for camera transform
    std::stringstream ss;
    ss << "glRotatef(" << -model.getCameraAngleZ() << ", 0,0,1);\n"
       << "glRotatef(" << -model.getCameraAngleY() << ", 0,1,0);\n"
       << "glRotatef(" << -model.getCameraAngleX() << ", 1,0,0);\n"
       << "glTranslatef(" << -model.getCameraX() << ", "
       << -model.getCameraY() << ", "
       << -model.getCameraZ() << ");\n"
       << std::ends;

    [textViewMatrix setStringValue:[NSString stringWithUTF8String:ss.str().c_str()]];
}



///////////////////////////////////////////////////////////////////////////////
- (void) updateModelMatrixCalls
{
    std::stringstream ss;
    ss << "glTranslatef(" << model.getModelX() 
       << ", " << model.getModelY() << ", "
       << model.getModelZ() << ");\n"
       << "glRotatef(" << model.getModelAngleX() << ", 1,0,0);\n"
       << "glRotatef(" << model.getModelAngleY() << ", 0,1,0);\n"
       << "glRotatef(" << model.getModelAngleZ() << ", 0,0,1);\n"
       << std::ends;

    [textModelMatrix setStringValue:[NSString stringWithUTF8String:ss.str().c_str()]];
}

@end
