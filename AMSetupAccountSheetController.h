//
//  AMSetupAccountSheetController.h
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMDispatch, AMServer, AMSession;
@protocol AMSetupAccountSheetControllerDelegate;

@interface AMSetupAccountSheetController : NSWindowController {
  id<AMSetupAccountSheetControllerDelegate> delegate;
  AMDispatch *dispatch;
  AMServer *server;
  AMSession *session;
}

+ (void)showSetupAccountSheetForWindow:(NSWindow *)window
                             withModel:(AMServer *)model 
                              dispatch:(AMDispatch *)dispatch
                              delegate:(id<AMSetupAccountSheetControllerDelegate>)delegate;

@property(nonatomic, readonly, retain) AMServer *server;
@property(nonatomic, readonly, retain) AMSession *session;

- (IBAction)cancel:(id)sender;
- (IBAction)create:(id)sender;

@end


@protocol AMSetupAccountSheetControllerDelegate
- (void)setupAccountSheetDidEnd:(AMSetupAccountSheetController *)controller returnCode:(NSUInteger)code;
@end
