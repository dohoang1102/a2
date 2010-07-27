//
//  AMSection.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol AMSectionEntry;

@interface AMSection : NSWindowController {
  NSMutableArray *entries;
  id<AMSectionEntry> active;
}

@property(nonatomic, readwrite, retain) id<AMSectionEntry> active;

@end

@interface AMSection (AMSectionAbstract)
- (NSString *)localizedName;

- (NSUInteger)countOfSectionEntries;
- (id<AMSectionEntry>)objectInSectionEntriesAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfSectionEntry:(id<AMSectionEntry>)entry;
@end
