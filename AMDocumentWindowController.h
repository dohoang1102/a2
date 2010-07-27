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
  AMViewControllerSwitch *contentView;
  AMViewControllerSwitch *sidebarView;
}

- (id)init;

@property(nonatomic, readwrite, retain) AMSidebarViewController *sidebar;

@property(nonatomic, readwrite, assign) IBOutlet AMViewControllerSwitch *sidebarView;
@property(nonatomic, readwrite, assign) IBOutlet AMViewControllerSwitch *contentView;

@end
