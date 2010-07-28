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


static void * AMSidebarViewControllerContext = (void *) @"AMSidebarViewControllerContext";

@implementation AMSidebarViewController
@synthesize delegate, sections, selectionIndexPaths, treeController;

- (id)init
{
  if(self = [super initWithNibName:@"Sidebar" bundle:nil]) {
    sections = [[AMSections alloc] init];
    
    [self addObserver:self 
           forKeyPath:@"selectionIndexPaths" 
              options:NSKeyValueObservingOptionNew 
              context:&AMSidebarViewControllerContext];
  }
  return self;
}

- (void)dealloc
{
  [self removeObserver:self forKeyPath:@"selectionIndexPaths"];
  delegate = nil;
  self.sections = nil;
  self.selectionIndexPaths = nil;
  [super dealloc];
}

#pragma mark -

- (void)selectionIndexPathsDidChange
{
  if(!selectionIndexPaths) {
    return;
  }
  
  NSIndexPath *path = [selectionIndexPaths lastObject];  
  if(!path || [path length] < 2) {
    return;
  }
  
  AMSection *section = [sections objectInSectionsAtIndex:[path indexAtPosition:0]];
  id<AMSectionEntry> sectionEntry = [section objectInModelsAtIndex:[path indexAtPosition:1]];
  
  [delegate sidebarViewController:self 
                 didSelectSection:section 
                     sectionEntry:sectionEntry];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if(context == &AMSidebarViewControllerContext) {
    if(object == self) {
      if([keyPath isEqualToString:@"selectionIndexPaths"]) {
        [self selectionIndexPathsDidChange];        
      }
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark -

- (id)outlineView:(NSOutlineView *)outlineView persistentObjectForItem:(id)item
{
  AMSection *section = [item representedObject];
  return [section persistentName];
}

- (id)treeNodeForRepresentedObject:(id)object
{
  for(id node in [[treeController arrangedObjects] childNodes]) {
    if([node representedObject] == object) {
      return node;
    }
  }
  return nil;
}

- (id)outlineView:(NSOutlineView *)outlineView itemForPersistentObject:(id)object
{
  AMSection *section = [sections sectionWithPersistentName:object];
  if(section) {
    return [self treeNodeForRepresentedObject:section];
  }
  return nil;
}

#pragma mark -

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
  id representedObject = [item representedObject];
  if([representedObject conformsToProtocol:@protocol(AMSectionEntry)]) {
    id<AMSectionEntry> sectionEntry = representedObject;
    AMSection *section = [[item parentNode] representedObject];
    BOOL shouldSelect = [delegate sidebarViewController:self willSelectSection:section sectionEntry:sectionEntry];
    if(!shouldSelect) {
      NSBeep();
    }
    return shouldSelect;
  }
  return NO;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
  return [[item representedObject] isKindOfClass:[AMSection class]];
}

@end
