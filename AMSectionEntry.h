//
//  AMSectionEntry.h
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMSectionNode.h"

@protocol AMSectionEntry <AMSectionNode>
- (NSString *)sectionEntryName;
@end


// Temporary
@interface AMSectionEntryImpl : NSObject <AMSectionEntry> {
  NSString *name;
}

- (id)initWithName:(NSString *)name;

@end
