//
//  AMSection.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSection.h"
#import "AMSectionEntry.h"


@implementation AMSection
@synthesize active;

- (id)init
{
  if(self = [super init]) {
    entries = [[NSArray arrayWithObjects:
               [[[AMSectionEntryImpl alloc] initWithName:@"1"] autorelease],
               [[[AMSectionEntryImpl alloc] initWithName:@"2"] autorelease],
               [[[AMSectionEntryImpl alloc] initWithName:@"3"] autorelease],
               [[[AMSectionEntryImpl alloc] initWithName:@"4"] autorelease],
               nil] retain];
  }
  return self;
}

- (void)dealloc
{
  self.active = nil;
  [super dealloc];
}

- (NSUInteger)countOfSectionEntries
{
  return [entries count];
}

- (id<AMSectionEntry>)objectInSectionEntriesAtIndex:(NSUInteger)index
{
  return [entries objectAtIndex:index];
}

@end
