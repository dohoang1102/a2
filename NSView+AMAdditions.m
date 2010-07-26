//
//  NSView+AMAdditions.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSView+AMAdditions.h"


@implementation NSView (AMAdditions)

- (void)addSubview:(NSView *)subview resizeToFit:(BOOL)resize
{
  if(resize) {
    NSRect bounds = [self bounds];
    subview.frame = NSMakeRect(.0f, .0f, bounds.size.width, bounds.size.height);
  }
  [self addSubview:subview];
}

@end
