//
//  AMSidebarViewController.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMSections, AMSection;
@protocol AMSectionEntry;

@interface AMSidebarViewController : NSViewController <NSOutlineViewDelegate> {
  AMSections *sections;
  NSOutlineView *outlineView;
  NSArray *selectionIndexPaths;
}

@property(nonatomic, readwrite, assign) NSOutlineView *outlineView;
@property(nonatomic, readwrite, retain) AMSections *sections;
@property(nonatomic, readwrite, retain) NSArray *selectionIndexPaths;

@end


@protocol AMSidebarViewControllerDelegate
@end