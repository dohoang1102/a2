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
@synthesize sections;

- (id)init
{
  if(self = [super init]) {
    self.sections = [NSArray arrayWithObjects:
//                     [[[AMBlogPostsSection alloc] init] autorelease],
//                     [[[AMDailyImagesSection alloc] init] autorelease],
//                     [[[AMImagesSection alloc] init] autorelease],
                     [[[AMSnippetsSection alloc] init] autorelease],
                     nil];
  }
  return self;
}

- (void)dealloc
{
  self.sections = nil;
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

- (NSUInteger)indexOfSection:(AMSection *)section
{
  return [sections indexOfObject:section];
}

@end
