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
@synthesize sections, activeSection, activeSectionEntry;

- (id)init
{
  if(self = [super init]) {
    self.sections = [NSArray arrayWithObjects:
                     [[[AMBlogPostsSection alloc] init] autorelease],
                     [[[AMDailyImagesSection alloc] init] autorelease],
                     [[[AMImagesSection alloc] init] autorelease],
                     [[[AMSnippetsSection alloc] init] autorelease],
                     nil];
    [self addObserver:self forKeyPath:@"activeSection" options:NSKeyValueObservingOptionNew context:self];
    [self addObserver:self forKeyPath:@"activeSectionEntry" options:NSKeyValueObservingOptionNew context:self];
  }
  return self;
}

- (void)dealloc
{
  [self removeObserver:self forKeyPath:@"activeSection"];
  [self removeObserver:self forKeyPath:@"activeSectionEntry"];
  self.sections = nil;
  self.activeSection = nil;
  self.activeSectionEntry = nil;
  [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if(context == self) {
    NSLog(@"AMSections • %@ – %@", keyPath, [change objectForKey:NSKeyValueChangeNewKey]);
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
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

@end
