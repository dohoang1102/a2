//
//  AMLoginSheetWindowController.h
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMServer;
@protocol AMLoginSheetWindowControllerDelegate;

@interface AMLoginSheetWindowController : NSWindowController {
  id<AMLoginSheetWindowControllerDelegate> delegate;
  BOOL busy;
  AMServer *server;
}

+ (void)presentLoginSheetForWindow:(NSWindow *)window
                         withModel:(AMServer *)model
                          delegate:(id<AMLoginSheetWindowControllerDelegate>)delegate;

@property(nonatomic, readonly) BOOL busy;

- (IBAction)cancel:(id)sender;
- (IBAction)create:(id)sender;

@end


@protocol AMLoginSheetWindowControllerDelegate
- (void)loginSheetDidEnd:(AMLoginSheetWindowController *)controller returnCode:(NSUInteger)code;
@end
