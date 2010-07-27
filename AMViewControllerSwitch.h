//
//  AMViewControllerSwitch.h
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AMViewControllerSwitch : NSObject {
  NSView *view;
  NSViewController *controller;
}

- (id)initWithParentView:(NSView *)view;

@property(nonatomic, readonly, retain) NSViewController *controller;

- (void)switchTo:(NSViewController *)controller;

@end
