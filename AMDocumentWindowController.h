//
//  AMDocumentWindowController.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMSidebarViewController;

@interface AMDocumentWindowController : NSWindowController <NSSplitViewDelegate> {
  AMSidebarViewController *sidebar;
  
  NSView *sidebarView;
  NSView *contentContent;
}

- (id)init;

@property(nonatomic, readwrite, retain) AMSidebarViewController *sidebar;

@property(nonatomic, readwrite, assign) IBOutlet NSView *sidebarView;
@property(nonatomic, readwrite, assign) IBOutlet NSView *contentView;

@end
