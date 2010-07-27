//
//  AMSections.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMSection;
@protocol AMSectionEntry;

@interface AMSections : NSObject {
  NSArray *sections;
  AMSection *activeSection;
  id<AMSectionEntry> activeSectionEntry;
}

- (NSUInteger)countOfSections;
- (AMSection *)objectInSectionsAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfSection:(AMSection *)section;


@property(nonatomic, readwrite, retain) AMSection *activeSection;
@property(nonatomic, readwrite, retain) id<AMSectionEntry> activeSectionEntry;

@end
