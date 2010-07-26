//
//  AMDocumentWindowController.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMDocumentWindowController.h"
#import "AMSidebarViewController.h"
#import "NSView+AMAdditions.h"


@implementation AMDocumentWindowController
@synthesize sidebar;
@synthesize sidebarView, contentView;

- (id)init
{
  if(self = [super initWithWindowNibName:@"Document"]) {
    NSLog(@"%@ %s", [self className], _cmd);
    sidebar = [[AMSidebarViewController alloc] init];
  }
  return self;
}

- (void)windowDidLoad
{
  NSLog(@"%@ %s %@", [self className], _cmd, self.document);

  [sidebar loadView];
  [sidebarView addSubview:[sidebar view] resizeToFit:YES];
}

- (void)dealloc
{
  NSLog(@"%@ %s", [self className], _cmd);
  self.sidebar = nil;
  [super dealloc];
}

#pragma mark -
#pragma mark Split view delegate

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)view
{
  // when resizing window, only content view should change it's size
  return view == contentView;
}

@end
