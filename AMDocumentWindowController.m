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
#import "AMSnippetsSection.h"
#import "AMSnippetViewController.h"
#import "AMBlankViewController.h"


static NSDictionary *AMSectionViewControllerClasses;


@interface AMDocumentWindowController ()
@property(nonatomic, readwrite, retain) NSViewController *contentViewController;
- (void)setContentViewControllerForSection:(AMSection *)section sectionEntry:(id<AMSectionEntry>)entry;
@end

@implementation AMDocumentWindowController
@synthesize sidebar;
@synthesize sidebarView, contentView;
@synthesize contentViewController;

+ (void)initialize
{
  AMSectionViewControllerClasses = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [AMSnippetViewController class], [AMSnippetsSection class],
                                    nil];
}

- (id)init
{
  if(self = [super initWithWindowNibName:@"Document"]) {
    NSLog(@"%@ %s", [self className], _cmd);
    sidebar = [[AMSidebarViewController alloc] init];
    sidebar.delegate = self;
  }
  return self;
}

- (void)windowDidLoad
{
  NSLog(@"%@ %s %@", [self className], _cmd, self.document);

  [sidebar loadView];
  [sidebarView addSubview:[sidebar view] resizeToFit:YES];
  [self setContentViewControllerForSection:nil sectionEntry:nil];
}

- (void)dealloc
{
  NSLog(@"%@ %s", [self className], _cmd);
  self.sidebar = nil;
  self.contentViewController = nil;
  [super dealloc];
}

#pragma mark -

- (Class)viewControllerClassForSection:(AMSection *)section
{
  return [AMSectionViewControllerClasses objectForKey:[section class]];
}

- (void)setContentViewController:(NSViewController *)controller
{
  if(contentViewController != controller) {
    [[contentViewController view] removeFromSuperview];
    [contentViewController release];
    
    contentViewController = [controller retain];
    [contentViewController loadView];
    [contentView addSubview:[contentViewController view] resizeToFit:YES];
  }
}

- (void)setContentViewControllerForSection:(AMSection *)section sectionEntry:(id<AMSectionEntry>)entry
{
  Class controllerClass = [self viewControllerClassForSection:section];
  NSViewController *controller = [[controllerClass alloc] init];
  if(controller) {
    [controller setRepresentedObject:entry];
    [self setContentViewController:controller];
    [controller release];
  } else {
    AMBlankViewController *controller = [[AMBlankViewController alloc] init];
    [self setContentViewController:controller];
    [controller release];
  }  
}

#pragma mark -
#pragma mark Split view delegate

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)view
{
  // when resizing window, only content view should change it's size
  return view == contentView;
}

#pragma mark -
#pragma mark Sidebar view controller delegate

- (BOOL)sidebarViewController:(AMSidebarViewController *)controller 
            willSelectSection:(AMSection *)section 
                 sectionEntry:(id<AMSectionEntry>)entry
{
  return [self viewControllerClassForSection:section] != nil;
}

- (void)sidebarViewController:(AMSidebarViewController *)sender
             didSelectSection:(AMSection *)section 
                 sectionEntry:(id<AMSectionEntry>)entry
{
  [self setContentViewControllerForSection:section sectionEntry:entry];
}

@end
