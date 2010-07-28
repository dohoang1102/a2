//
//  AMLoginSheetWindowController.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMLoginSheetWindowController.h"
#import "NSWindow+AMAdditions.h"


@interface AMLoginSheetWindowController ()
@property(nonatomic, readwrite, assign) id<AMLoginSheetWindowControllerDelegate> delegate;
@property(nonatomic, readwrite) BOOL busy;
@property(nonatomic, readwrite, retain) AMServer *server;
@end

@implementation AMLoginSheetWindowController
@synthesize busy, delegate, server;

+ (void)presentLoginSheetForWindow:(NSWindow *)window
                         withModel:(AMServer *)model
                          delegate:(id<AMLoginSheetWindowControllerDelegate>)delegate
{
  AMLoginSheetWindowController *controller = [[AMLoginSheetWindowController alloc] init];
  controller.delegate = delegate;
  controller.server = model;
  
  [NSApp beginSheet:[controller window]
     modalForWindow:window 
      modalDelegate:controller 
     didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
        contextInfo:nil];
}

- (id)init
{
  if(self = [super initWithWindowNibName:@"Login"]) {
  }
  return self;
}

- (void)dealloc
{
  self.delegate = nil;
  self.server = nil;
  [super dealloc];
}

- (IBAction)cancel:(id)sender
{
  [[self window] orderOut:nil];
  [NSApp endSheet:[self window] returnCode:NSCancelButton];  
}

- (IBAction)create:(id)sender
{
  [[self window] endEditing];
  self.busy = YES;
  [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerDidFire:) userInfo:nil repeats:NO];
}

- (void)timerDidFire:(NSTimer *)timer
{
  self.busy = NO;
  [[self window] orderOut:nil];
  [NSApp endSheet:[self window] returnCode:NSOKButton];  
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
  [self.delegate loginSheetDidEnd:self returnCode:returnCode];
  [self release];
}

@end
