//
//  AMSetupAccountSheetController.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSetupAccountSheetController.h"
#import "NSWindow+AMAdditions.h"
#import "AMSession.h"
#import "AMServer.h"


@interface AMSetupAccountSheetController ()
@property(nonatomic, readwrite, assign) id<AMSetupAccountSheetControllerDelegate> delegate;
@property(nonatomic, readwrite) BOOL busy;
@property(nonatomic, readwrite, retain) AMServer *server;
@property(nonatomic, readwrite, retain) AMDispatch *dispatch;
@end

@implementation AMSetupAccountSheetController
@synthesize busy, delegate, dispatch, server;

+ (void)showSetupAccountSheetForWindow:(NSWindow *)window
                             withModel:(AMServer *)model
                              dispatch:(AMDispatch *)dispatch
                              delegate:(id<AMSetupAccountSheetControllerDelegate>)delegate
{
  AMSetupAccountSheetController *controller = [[AMSetupAccountSheetController alloc] init];
  controller.delegate = delegate;
  controller.server = model;
  controller.dispatch = dispatch;
  
  [NSApp beginSheet:[controller window]
     modalForWindow:window 
      modalDelegate:controller 
     didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
        contextInfo:nil];
}

- (id)init
{
  if(self = [super initWithWindowNibName:@"SetupAccount"]) {
  }
  return self;
}

- (void)dealloc
{
  self.delegate = nil;
  self.server = nil;
  self.dispatch = nil;
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
  NSLog(@"%@", self.server);
  AMSession *session = [[AMSession alloc] initWithDispatch:dispatch];
  session.login    = server.login;
  session.password = server.password;
  [session createWithTarget:self success:@selector(loginDidSucceed:) failed:@selector(loginDidFail:withError:)];
}

- (void)loginDidSucceed:(AMSession *)sender
{
  NSLog(@"%@ %s", [self className], _cmd);
}

- (void)loginDidFail:(AMSession *)sender withError:(NSError *)error
{
  NSLog(@"%@ %s %@", [self className], _cmd, error);  
}

- (void)timerDidFire:(NSTimer *)timer
{
  self.busy = NO;
  [[self window] orderOut:nil];
  [NSApp endSheet:[self window] returnCode:NSOKButton];  
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
  [self.delegate setupAccountSheetDidEnd:self returnCode:returnCode];
  [self release];
}

@end
