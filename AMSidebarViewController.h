//
//  AMSidebarViewController.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMSections;

@interface AMSidebarViewController : NSViewController <NSOutlineViewDelegate> {
  AMSections *sections;
  NSOutlineView *outlineView;
}

@property(nonatomic, readwrite, assign) NSOutlineView *outlineView;
@property(nonatomic, readwrite, retain) AMSections *sections;

- (IBAction)selectRowAction:(id)sender;

@end


@protocol AMSidebarViewControllerDelegate
@end