//
//  AMSection.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMSectionNode.h"


@protocol AMSectionEntry;

@interface AMSection : NSObject {
}

@end

@interface AMSection (AMSectionTreeNode) <AMSectionNode>
@end

@interface AMSection (AMSectionAbstract)
- (NSString *)localizedName;

- (NSUInteger)countOfSectionEntries;
- (id<AMSectionEntry>)objectInSectionEntriesAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfSectionEntry:(id<AMSectionEntry>)entry;

@end
