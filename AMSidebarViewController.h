//
//  AMSidebarViewController.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMSections, AMSection;
@protocol AMSectionEntry, AMSidebarViewControllerDelegate;

@interface AMSidebarViewController : NSViewController <NSOutlineViewDataSource, NSOutlineViewDelegate> {
  id<AMSidebarViewControllerDelegate> delegate;
  AMSections *sections;
  NSTreeController *treeController;
  NSArray *selectionIndexPaths;
}

@property(nonatomic, readwrite, assign) id<AMSidebarViewControllerDelegate> delegate;
@property(nonatomic, readwrite, assign) IBOutlet NSTreeController *treeController;
@property(nonatomic, readwrite, retain) AMSections *sections;
@property(nonatomic, readwrite, retain) NSArray *selectionIndexPaths;

@end


@protocol AMSidebarViewControllerDelegate

- (BOOL)sidebarViewController:(AMSidebarViewController *)controller 
            willSelectSection:(AMSection *)section 
                 sectionEntry:(id<AMSectionEntry>)entry;

- (void)sidebarViewController:(AMSidebarViewController *)controller 
             didSelectSection:(AMSection *)section 
                 sectionEntry:(id<AMSectionEntry>)entry;

@end