//
//  AMSections.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSections.h"
#import "AMBlogPostsSection.h"
#import "AMDailyImagesSection.h"
#import "AMImagesSection.h"
#import "AMSnippetsSection.h"


@interface AMSections ()
@property(nonatomic, readwrite, retain) NSArray *sections;
@end

@implementation AMSections
@synthesize sections, active;

- (id)init
{
  if(self = [super init]) {
    self.sections = [NSArray arrayWithObjects:
                     [[[AMBlogPostsSection alloc] init] autorelease],
                     [[[AMDailyImagesSection alloc] init] autorelease],
                     [[[AMImagesSection alloc] init] autorelease],
                     [[[AMSnippetsSection alloc] init] autorelease],
                     nil];
  }
  return self;
}

- (void)dealloc
{
  self.sections = nil;
  self.active   = nil;
  [super dealloc];
}

#pragma mark -

- (NSUInteger)countOfSections
{
  return [sections count];
}

- (AMSection *)objectInSectionsAtIndex:(NSUInteger)index
{
  return [sections objectAtIndex:index];
}

#pragma mark -

- (void)setActive:(AMSection *)section entry:(id<AMSectionEntry>)item
{
  if(active != section) {
    [active setActive:nil];
    self.active = section;
  }
  if(active.active != item) {
    active.active = item;
  }
}

@end
