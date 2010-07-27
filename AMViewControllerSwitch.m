//
//  AMViewControllerSwitch.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMViewControllerSwitch.h"
#import "NSView+AMAdditions.h"


@interface AMViewControllerSwitch ()
@property(nonatomic, readwrite, retain) NSView *view;
@property(nonatomic, readwrite, retain) NSViewController *controller;
@end

@implementation AMViewControllerSwitch
@synthesize view, controller;

- (id)initWithParentView:(NSView *)aView
{
  if(self = [super init]) {
    self.view = aView;
  }
  return self;
}

- (void)dealloc
{
  [self switchTo:nil];
  self.view = nil;
  [super dealloc];
}

- (void)switchTo:(NSViewController *)next
{
  if(controller != next) {
    [[controller view] removeFromSuperview];
    self.controller = next;
    if(controller) {
      [next loadView];
      [view addSubview:[controller view] resizeToFit:YES];      
    }
  }
}

@end
