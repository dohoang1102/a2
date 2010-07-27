//
//  AMDocumentWindowController.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMSidebarViewController.h"


@class AMViewControllerSwitch;

@interface AMDocumentWindowController : NSWindowController <NSSplitViewDelegate, AMSidebarViewControllerDelegate> {
  AMSidebarViewController *sidebar;
  AMViewControllerSwitch *content;
  NSView *sidebarView;
  NSView *contentView;
}

- (id)init;

@property(nonatomic, readwrite, retain) AMSidebarViewController *sidebar;

@property(nonatomic, readwrite, assign) IBOutlet NSView *sidebarView;
@property(nonatomic, readwrite, assign) IBOutlet NSView *contentView;

@end
