//
//  AMSidebarViewController.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSidebarViewController.h"
#import "AMSections.h"
#import "AMSection.h"
#import "AMSectionEntry.h"


@implementation AMSidebarViewController
@synthesize outlineView, sections;

- (id)init
{
  if(self = [super initWithNibName:@"Sidebar" bundle:nil]) {
    NSLog(@"%@ %s", [self className], _cmd);
    sections = [[AMSections alloc] init];
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"%@ %s", [self className], _cmd);
  self.sections = nil;
  [super dealloc];
}

#pragma mark -

// TODO: Maybe try to get "Selection Index Paths" to work?
- (IBAction)selectRowAction:(id)sender
{
  NSInteger row = [sender selectedRow];
  if(row != -1) {
    NSTreeNode *itemNode = [sender itemAtRow:row];
    id entry = [itemNode representedObject];
    if(entry && [entry conformsToProtocol:@protocol(AMSectionEntry)]) {
      NSTreeNode *sectionNode = [sender parentForItem:itemNode];
      if(sectionNode) {
        AMSection *section = [sectionNode representedObject];
        [sections setActive:section entry:entry];
      }
    }
  }
}

#pragma mark -

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
  if([item isKindOfClass:[NSTreeNode class]]) {
    id representedObject = [item representedObject];
    return ![representedObject isKindOfClass:[AMSection class]];
  }
  return NO;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
  if([item isKindOfClass:[NSTreeNode class]]) {
    id representedObject = [item representedObject];
    return [representedObject isKindOfClass:[AMSection class]];
  }
  return NO;
}

@end
