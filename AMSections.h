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
  AMSection *active;
}

- (NSUInteger)countOfSections;
- (AMSection *)objectInSectionsAtIndex:(NSUInteger)index;

@property(nonatomic, readwrite, retain) AMSection *active;

- (void)setActive:(AMSection *)section entry:(id<AMSectionEntry>)item;

@end
