//
//  NSView+AMAdditions.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSView (AMAdditions)

- (void)addSubview:(NSView *)subview resizeToFit:(BOOL)resize;

@end
