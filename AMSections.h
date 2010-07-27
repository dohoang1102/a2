//
//  AMSections.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMSection;

@interface AMSections : NSObject {
  NSArray *sections;
}

- (NSUInteger)countOfSections;
- (AMSection *)objectInSectionsAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfSection:(AMSection *)section;

- (AMSection *)sectionWithPersistentName:(NSString *)persistentName;

@end
