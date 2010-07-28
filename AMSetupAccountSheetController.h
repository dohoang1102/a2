//
//  AMSetupAccountSheetController.h
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMServer;
@protocol AMSetupAccountSheetControllerDelegate;

@interface AMSetupAccountSheetController : NSWindowController {
  id<AMSetupAccountSheetControllerDelegate> delegate;
  BOOL busy;
  AMServer *server;
}

+ (void)showSetupAccountSheetForWindow:(NSWindow *)window
                             withModel:(AMServer *)model
                              delegate:(id<AMSetupAccountSheetControllerDelegate>)delegate;

@property(nonatomic, readonly) BOOL busy;
@property(nonatomic, readonly, retain) AMServer *server;

- (IBAction)cancel:(id)sender;
- (IBAction)create:(id)sender;

@end


@protocol AMSetupAccountSheetControllerDelegate
- (void)setupAccountSheetDidEnd:(AMSetupAccountSheetController *)controller returnCode:(NSUInteger)code;
@end
