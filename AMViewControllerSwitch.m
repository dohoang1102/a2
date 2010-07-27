//
//  AMViewControllerSwitch.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMViewControllerSwitch.h"
#import "NSView+AMAdditions.h"


@implementation AMViewControllerSwitch
@synthesize view, controller;

- (void)dealloc
{
  self.controller = nil;
  self.view = nil;
  [super dealloc];
}

- (void)setController:(NSViewController *)next
{
  if(controller != next) {
    [[controller view] removeFromSuperview];
    [controller release];
    controller = [next retain];
    if(controller) {
      [next loadView];
      [view addSubview:[controller view] resizeToFit:YES];      
    }
  }
}

@end
